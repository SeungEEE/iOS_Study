//
//  SizeModel.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/13/25.
//

import Foundation

/// 상품 구매 뷰의 사이즈 선택 데이터
struct SizeModel {
    var size: String
    var price: String
}

// MARK: - Dummy Data

final class SizeData {
    static let sizeData: [SizeModel] = [
        .init(size: "S", price: "360,000"),
        .init(size: "M", price: "360,000"),
        .init(size: "L", price: "360,000"),
        .init(size: "XL", price: "360,000"),
        .init(size: "XXL", price: "360,000"),
    ]
}
