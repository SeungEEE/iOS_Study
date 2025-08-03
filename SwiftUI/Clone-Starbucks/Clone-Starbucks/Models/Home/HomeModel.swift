//
//  HomeModel.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/7/25.
//

import SwiftUI

/// 커피 카드 모델
struct CoffeeCardModel: Identifiable {
    let id = UUID() // 테이블 id
    let coffeeId: Int // 커피 id
    let coffeeImage: UIImage
    let title: String
}

// 테이블 매핑
struct DetailCoffee {
    let coffeeId: Int
    let coffeeImage: UIImage
    let title: String
    let titleInEnglish: String
    let Description: String
    let price: String
    
    let state: CoffeeState
    
    enum CoffeeState: String, CaseIterable {
        case hot = "HOT"
        case iced = "ICED"
    }
}

/// 광고 배너 모델
struct AdBannerModel: Identifiable {
    let id = UUID()
    let adImage: UIImage
    let title: String
    let description: String
}

/// 디저트 카드 모델
struct DessertCardModel: Identifiable {
    let id = UUID()
    let dessertImage: UIImage
    let title: String
}
