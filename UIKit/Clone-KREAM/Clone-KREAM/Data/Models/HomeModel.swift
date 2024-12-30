//
//  HomeModel.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/18/24.
//

import Foundation

/// 광고 배너 - 1번째 색션
struct AdBannerModel: RequiredCellProtocol {
    var imageView: String
}

/// 판매 상품 데이터 - 2번째 섹션
struct RecommendationModel: RequiredCellProtocol {
    var imageView: String
    var titleLabel: String
}

/// 발매 상품 데이터 - 3번째 섹션
struct ProductModel: RequiredCellProtocol {
    var imageView: String
    var productCount: String
    var selectedTag: Bool
    var titleLabel: String
    var subTitleLabel: String
    var priceLabel: String
    var priceSubLabel: String
}

final class HomeModel {
    /// 광고 배너 데이터 - 1번째 섹션
    static let adBannerData: [AdBannerModel] = [
        .init(imageView: "adImage")
    ]
    
    /// 판매 상품 데이터 - 2번째 섹션
    static let recomendationData: [RecommendationModel] = [
        .init(imageView: "home1", titleLabel: "크림 드로우"),
        .init(imageView: "home2", titleLabel: "실시간 차트"),
        .init(imageView: "home3", titleLabel: "남성 추천"),
        .init(imageView: "home4", titleLabel: "여성 추천"),
        .init(imageView: "home5", titleLabel: "색다른 추천"),
        .init(imageView: "home6", titleLabel: "정가 아래"),
        .init(imageView: "home7", titleLabel: "윤세 24AW"),
        .init(imageView: "home8", titleLabel: "올해의 베스트"),
        .init(imageView: "home9", titleLabel: "10월 베네핏"),
        .init(imageView: "home10", titleLabel: "아크네 선물")
    ]
    
    /// 발매 상품 데이터 - 3번째 섹션
    static let productData: [ProductModel] = [
        .init(imageView: "product1", productCount: "거래 12.8만", selectedTag: false, titleLabel: "MLB", subTitleLabel: "청키라이너 뉴욕양키스", priceLabel: "139,000원", priceSubLabel: "즉시 구매가"),
        .init(imageView: "product2", productCount: "거래 15.6만", selectedTag: true, titleLabel: "Jordan", subTitleLabel: "Jordan 1 Retro High OG Yellow Ochre", priceLabel: "228,000원", priceSubLabel: "즉시 구매가"),
        .init(imageView: "product3", productCount: "거래 18.4만", selectedTag: true, titleLabel: "Human", subTitleLabel: "Human MASEW", priceLabel: "228,000원", priceSubLabel: "즉시 구매가"),
        .init(imageView: "product1", productCount: "거래 12.8만", selectedTag: false, titleLabel: "MLB", subTitleLabel: "청키라이너 뉴욕양키스", priceLabel: "139,000원", priceSubLabel: "즉시 구매가"),
        .init(imageView: "product2", productCount: "거래 15.6만", selectedTag: true, titleLabel: "Jordan", subTitleLabel: "Jordan 1 Retro High OG Yellow Ochre", priceLabel: "228,000원", priceSubLabel: "즉시 구매가"),
        .init(imageView: "product3", productCount: "거래 18.4만", selectedTag: true, titleLabel: "Human", subTitleLabel: "Human MASEW", priceLabel: "228,000원", priceSubLabel: "즉시 구매가"),
    ]
}

