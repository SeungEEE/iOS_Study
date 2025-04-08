//
//  HomeViewModel.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/7/25.
//

import SwiftUI

@Observable
class HomeViewModel {
    let coffeeCard: [CoffeeCardModel] = [
        .init(coffeeId: 1, coffeeImage: .coffee01, title: "에스프레소 콘파나"),
        .init(coffeeId: 2, coffeeImage: .coffee02, title: "에스프레소 마키아또"),
        .init(coffeeId: 3, coffeeImage: .coffee03, title: "아이스 카페 아메리카노"),
        .init(coffeeId: 4, coffeeImage: .coffee04, title: "카페 아메리카노"),
        .init(coffeeId: 5, coffeeImage: .coffee05, title: "아이스 카라멜 마끼아또"),
        .init(coffeeId: 6, coffeeImage: .coffee06, title: "카라멜 마끼아또")
    ]
    
    let coffeeDetail: [DetailCoffee] = [
        .init(coffeeId: 1, coffeeImage: .detailCoffee01, title: "에스프레소 콘 파나", titleInEnglish: "Espresso Con Panna", Description: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료", price: "4,100원", state: .hot),
        .init(coffeeId: 2, coffeeImage: .detailCoffee02, title: "에스프레소 마끼아또", titleInEnglish: "Espresso Macchiato", Description: "신선한 에스프레소 샷에 우유 거품을 살짝 얹은 커피 음료로서, 강렬한 에스프레소의 맛과 우유의 부드러움을 같이 즐길 수 있는 커피 음료", price: "3,900원", state: .iced),
        .init(coffeeId: 3, coffeeImage: .detailCoffee03, title: "아이스 카페 아메리카노", titleInEnglish: "Iced Caffe Americano", Description: "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피", price: "4,700원", state: .iced),
        .init(coffeeId: 4, coffeeImage: .detailCoffee04, title: "카페 아메리카노", titleInEnglish: "Caffe Americano", Description: "진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽게 잘 느낄 수 있는 커피", price: "4,700원", state: .hot),
        .init(coffeeId: 5, coffeeImage: .detailCoffee05, title: "아이스 카라멜 마끼아또", titleInEnglish: "Iced Caramel Macchiato", Description: "향긋한 바닐라 시럽과 시원한 우유에 얼음을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price: "6,100원", state: .iced),
        .init(coffeeId: 6, coffeeImage: .detailCoffee06, title: "카라멜 마끼아또", titleInEnglish: "Caramel Macchiato", Description: "향긋한 바닐라 시럽과 따뜻한 스팀 밀크 위에 풍성한 우유 거품을 얹고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price: "6,100원", state: .hot)
    ]
    
    let adCard: [AdBannerModel] = [
        .init(adImage: .ad01, title: "25년 3월 일회용품 없는 날 캠페..", description: "매월 10일은 일회용컵 없는 날! 스타벅스 에모매장에서 개인컵 및 다회용 컵을 이용하세요."),
        .init(adImage: .ad02, title: "스타벅스 ooo점을 찾습니다", description: "스타벅스 커뮤니티 스토어 파트너를 웅영할 기관을 공모합니다."),
        .init(adImage: .ad03, title: "2월 8일, 리저브 스프링 신규 커...", description: "산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세요.")
    ]
    
    let dessertCard: [DessertCardModel] = [
        .init(dessertImage: .dessert01, title: "너티 크루아상"),
        .init(dessertImage: .dessert02, title: "매콤 소시지 불고기"),
        .init(dessertImage: .dessert03, title: "미니 리프 파이"),
        .init(dessertImage: .dessert04, title: "뺑 오 쇼콜라"),
        .init(dessertImage: .dessert05, title: "소시지&올리브 파이")
    ]
    
    /// id로 상세 정보 찾는 함수
    func detail(for coffeeId: Int) -> DetailCoffee {
        coffeeDetail.first(where: { $0.coffeeId == coffeeId })!
    }
    
}
