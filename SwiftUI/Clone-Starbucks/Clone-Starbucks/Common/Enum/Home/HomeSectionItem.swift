//
//  HomeSectionItem.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/4/25.
//

import Foundation

/// 홈 화면에서 사용할 컨텐츠 항목 나타내는 열거형
/// 배너와 색션 구분하여 표현
enum HomeContentItem: Identifiable {
    
    /// 배너 컨텐츠 항목
    case banner(BannerItem)
    
    /// 가로 스크롤 형태의 섹션 컨텐츠 항목
    case section(HomeSection)
    
    /// 각 컨텐츠 항목 고유 ID
    var id: UUID {
        switch self {
        case .banner(let item):
            return item.id
        case .section(let section):
            return section.id
        }
    }
}

/// 홈 화면의 섹션 컨텐츠 타입 정의한 열거형
enum HomeSectionType {
    
    /// 커피 컨텐츠
    case coffee
    
    /// 신규 출시 컨텐츠
    case newRelease
    
    /// 디저트 컨텐츠
    case dessert
}
