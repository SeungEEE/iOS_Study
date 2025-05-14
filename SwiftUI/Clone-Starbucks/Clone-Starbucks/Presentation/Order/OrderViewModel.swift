//
//  OrderViewModel.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/29/25.
//

import SwiftUI

@Observable
class OrderViewModel {
    var selectedSegment: OrderSegment = .first {
        didSet {
            
        }
    }
    
    let menuList: [OrderModel] = [
        .init(name: "추천", nameEnglish: "Recommend", image: .order1),
        .init(name: "아이스 카페 아메리카노", nameEnglish: "Iced Caffe Americano", image: .order2),
        .init(name: "카페 아메리카노", nameEnglish: "Reserve Drip", image: .order3),
        .init(name: "카푸치노", nameEnglish: "Cappuccino", image: .order4),
        .init(name: "아이스 카푸치노", nameEnglish: "Iced Cappuccino", image: .order5),
        .init(name: "카라멜 마키아또", nameEnglish: "Caramel Macchiato", image: .order6),
        .init(name: "아이스 카라멜 마키아또", nameEnglish: "Iced Caramel Macchiato", image: .order7),
        .init(name: "아포가토/기타", nameEnglish: "Affogato / Others", image: .order8),
        .init(name: "럼 샷 코르타도", nameEnglish: "Rum Shot Cortado", image: .order9),
        .init(name: "라벤더 카페 브레베", nameEnglish: "Lavender Caffe Breve", image: .order10),
        .init(name: "병음료", nameEnglish: "RTD", image: .order11)
    ]
}
