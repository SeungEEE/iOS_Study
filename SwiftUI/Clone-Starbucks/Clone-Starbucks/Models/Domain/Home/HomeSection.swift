//
//  HomeSection.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/4/25.
//

import Foundation

/// 가로 스크롤 형태의 섹션 컨텐츠 모델
struct HomeSection: Identifiable {
    let id = UUID()
    let title: String
    let items: [any Identifiable]
    let contentType: HomeSectionType
}
