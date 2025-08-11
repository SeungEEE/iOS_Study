//
//  DessertMenuItem.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/5/25.
//

import SwiftUI

struct DessertMenuItem: Identifiable, MenuItemAttr {
    let id: UUID = .init()
    var name: String
    var thumbnailImage: ImageResource
}
