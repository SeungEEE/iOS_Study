//
//  ReceiptsViewModel.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/15/25.
//

import SwiftUI
import Vision

@Observable
class ReceiptsViewModel: ImageHandling {
    var images: [UIImage] = []
    
    var receipts: [ReceiptsModel] = []
    
    var recognizedText: String = ""

    func addImage(_ image: UIImage) {
        images.append(image)
        performOCR(on: image)
    }
    
    func appendReceipt(from text: String) {
        let receipt = parseWithoutRefx(from: text)
        receipts.append(receipt)
    }

    func removeImage(at index: Int) {
        guard images.indices.contains(index) else { return }
        images.remove(at: index)
    }

    func getImages() -> [UIImage] {
        images
    }
    
    private func performOCR(on uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else { return }

        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let self,
                  let results = request.results as? [VNRecognizedTextObservation] else { return }
            let recognizedStrings = results.compactMap { $0.topCandidates(1).first?.string }
            let text = recognizedStrings.joined(separator: "\n")

            DispatchQueue.main.async {
                self.recognizedText = text
                let receipt = self.parseWithoutRefx(from: text)

                // 이미지와 연결
                let imageModel = ReceiptImage(image: uiImage)
                receipt.receiptImage = imageModel

                self.receipts.append(receipt)
            }
        }

        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        request.recognitionLanguages = ["ko-KR", "en-US"]

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            try? handler.perform([request])
        }
    }

    private func parseWithoutRefx(from text: String) -> ReceiptsModel {
        let lines = text.components(separatedBy: .newlines)
        
        var store = "장소 없음"
        var totalAmount = 0
        var time = "날짜 없음"

        var i = 0
        
        print("-- 디버그 시작 --")
        
        while i < lines.count {
            let trimmed = lines[i].trimmingCharacters(in: .whitespacesAndNewlines)
            print("🔹 [\(i)] \(trimmed)")
            
            // 장소
            if store == "장소 없음", trimmed.contains("점") {
                store = "스타벅스 " + trimmed
            }
            
            // 결제 금액
            if trimmed.contains("결제금액"), i + 2 < lines.count {
                let priceLine = lines[i + 2].trimmingCharacters(in: .whitespaces)
                let numberOnly = priceLine.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                if let amount = Int(numberOnly) {
                    totalAmount = amount
                }
            }
            
            // 날짜
            let datePattern = #"(\d{4})[-.](\d{2})[-.](\d{2})\s*(\d{2}):(\d{2}):(\d{2})"#
            let dateRegex = try! NSRegularExpression(pattern: datePattern)
            let range = NSRange(location: 0, length: trimmed.utf16.count)
            if let match = dateRegex.firstMatch(in: trimmed, options: [], range: range) {
                var matched = (trimmed as NSString).substring(with: match.range)
                if matched.count == 19, !matched.contains(" ") {
                    let index = matched.index(matched.startIndex, offsetBy: 10)
                    matched.insert(" ", at: index)
                }
                
                time = matched
            }
            i += 1
        }
        
        print("===== OCR 디버그 끝 =====")
        print("🏪 매장명: \(store)")
        print("💰 결제 금액: \(totalAmount)")
        print("🧾 결제 시간: \(time)")
        
        return ReceiptsModel(
            store: store,
            totalAmount: totalAmount,
            time: time
        )
    }
}
