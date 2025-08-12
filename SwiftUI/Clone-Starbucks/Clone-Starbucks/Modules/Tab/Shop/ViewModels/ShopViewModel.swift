//
//  ShopViewModel.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/13/25.
//

import SwiftUI

@Observable
class ShopViewModel {
    let topBanner: [ShopTopModel] = [
        .init(bannerImage: .shopBanner1),
        .init(bannerImage: .shopBanner2),
        .init(bannerImage: .shopBanner3)
    ]
    
    let allProducts: [ShopProductModel] = [
        .init(image: .product1, title: "텀블러"),
        .init(image: .product2, title: "커피 용품"),
        .init(image: .product3, title: "선물 세트"),
        .init(image: .product4, title: "보온병"),
        .init(image: .product5, title: "머그/컵"),
        .init(image: .product6, title: "라이프스타일")
    ]
    
    let bestProducts: [ShopBestProductModel] = [
        .init(image: .bestItem1, title: "그린 사이렌 슬리브 머그 355ml"),
        .init(image: .bestItem2, title: "그린 사이렌 클래식 머그 355ml"),
        .init(image: .bestItem3, title: "사이렌 머그 앤 우드 소서"),
        .init(image: .bestItem4, title: "리저브 골드 테일 머그 355ml"),
        .init(image: .bestItem5, title: "블랙 앤 골드 머그 473ml"),
        .init(image: .bestItem6, title: "블랙 링 머그 355ml"),
        .init(image: .bestItem7, title: "북청사자놀음 데미머그 89ml"),
        .init(image: .bestItem8, title: "서울 제주 데미머그 세트")
    ]
    
    let newProducts: [ShopNewProductModel] = [
        .init(image: .newProduct1, title: "그린 사이렌 도트 머그 237ml"),
        .init(image: .newProduct2, title: "리저브 골드 테일 머그 355ml"),
        .init(image: .newProduct3, title: "홈 카페 미니 머그 세트"),
        .init(image: .newProduct4, title: "홈 카페 글라스 세트")
    ]
}
