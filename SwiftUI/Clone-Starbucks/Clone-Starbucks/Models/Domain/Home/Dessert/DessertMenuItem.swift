//
//  DessertMenuItem.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/5/25.
//

import SwiftUI

/// 디저트 정보 담는 모델
struct DessertMenuItem: Identifiable, MenuItemAttr {
    let id: UUID = .init()
    var name: String
    var thumbnailImage: ImageResource
}
