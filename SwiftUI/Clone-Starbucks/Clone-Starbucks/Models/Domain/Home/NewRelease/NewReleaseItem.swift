//
//  NewReleaseItem.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/5/25.
//

import SwiftUI

/// What's New 데이터 담는 모델
struct NewReleaseItem: Identifiable {
    let id: UUID = .init()
    let image: ImageResource
    let name: String
    let description: String
}
