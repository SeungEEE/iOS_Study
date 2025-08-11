//
//  BannerItem.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/4/25.
//

import SwiftUI

/// 홈 배너 아이템 모델
struct BannerItem: Identifiable {
    let id: UUID = .init()
    let image: ImageResource
}
