//
//  CoffeeSummaryItem.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/3/25.
//

import SwiftUI

/// 커피 요약 아이템 모델
struct CoffeeSummaryItem: Identifiable, MenuItemAttr {
    let id: UUID
    var name: String
    var thumbnailImage: ImageResource
}
