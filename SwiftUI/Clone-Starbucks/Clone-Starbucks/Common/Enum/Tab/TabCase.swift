//
//  TabCase.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/26/25.
//

import SwiftUI

/// 앱 하단 탭바에 표시될 열거형
enum TabCase: String, CaseIterable {
    /// 홈 탭
    case home = "Home"
    
    /// 결제 탭
    case pay = "pay"
    
    /// 주문 탭
    case order = "Order"
    
    /// 매장/쇼핑 탭
    case shop = "Shop"
    
    /// 기타 탭 (설정, 계정 등)
    case other = "Other"
    
    /// 각 탭의 대응되는 아이콘 이미지로 반환
    var icon: Image {
        switch self {
        case .home:
            return .init(.homeIcon)
        case .pay:
            return .init(systemName: "creditcard")
        case .order:
            return .init(.orderIcon)
        case .shop:
            return .init(.shopIcon)
        case .other:
            return .init(systemName: "ellipsis")
        }
    }
}
