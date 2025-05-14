//
//  OrderSegment.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/29/25.
//

import Foundation

enum OrderSegment: Int, CaseIterable, Identifiable {
    case first
    case second
    case third
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .first:
            return "전체 메뉴"
        case .second:
            return "나만의 메뉴"
        case .third:
            return "홀케이크 예약"
        }
    }
}

enum OrderTypeSegment: String, CaseIterable, Identifiable {
    case drink = "음료"
    case food = "푸드"
    case product = "상품"
    
    var id: String { rawValue }
}
