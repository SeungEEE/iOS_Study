//
//  DessertDataSource.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/5/25.
//

import Foundation

/// 디저트 더미 데이터
struct DessertDataSource {
    static let dessertItems: [DessertMenuItem] = [
        .init(name: "너티 크루아상", thumbnailImage: .dessert01),
        .init(name: "매콤 소시지 불고기", thumbnailImage: .dessert02),
        .init(name: "미니 리프 파이", thumbnailImage: .dessert03),
        .init(name: "뺑 오 쇼콜라", thumbnailImage: .dessert04),
        .init(name: "소시지&올리브 파이", thumbnailImage: .dessert05)
    ]
}
