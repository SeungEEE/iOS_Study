//
//  ISBNScannerViewModel.swift
//  SwiftUI-Workbook
//
//  Created by 이승진 on 5/15/25.
//

import Alamofire
import SwiftUI

@Observable
class ISBNScannerViewModel {
    
    var bookModel: BookModel.Documents?
    var errorMessage: String?
    var isShowSaveView: Bool = false
    
    func searchBook(isbn: String) async {
        self.errorMessage = nil
        
        do {
            let result = try await KakaoAPIService.shared.searchBook(query: isbn)
            self.bookModel = result.documents.first
            isShowSaveView = true
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    
    public func purchaseBook() {
        if let urlString = self.bookModel?.url,
           let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("구매 링크 연결 x")
        }
    }
}




