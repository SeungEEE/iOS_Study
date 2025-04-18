//
//  ReceiptsModel.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/15/25.
//

import SwiftUI
import SwiftData

@Model
class ReceiptsModel {
    @Attribute(.unique) var id: UUID
    
    var store: String    // 장소
    var totalAmount: Int // 결제 금액
    var time: String     // 날짜
    
    @Relationship var receiptImage: ReceiptImage?
    
    init(
        store: String,
        totalAmount: Int,
        time: String,
        receiptImage: ReceiptImage? = nil
    ) {
        self.id = UUID()
        self.store = store
        self.totalAmount = totalAmount
        self.time = time
        self.receiptImage = receiptImage
    }
}

@Model
class ReceiptImage {
    @Attribute(.externalStorage) var imageData: Data?
    
    init(image: UIImage) {
        self.imageData = image.jpegData(compressionQuality: 0.9)
    }
    
    func toUIImage() -> UIImage? {
        guard let data = imageData else { return nil }
        return UIImage(data: data)
    }
}
