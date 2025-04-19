//
//  ShopModel.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/13/25.
//

import SwiftUI

struct ShopTopModel: Identifiable {
    let id = UUID()
    let bannerImage: UIImage
}

struct ShopProductModel: Identifiable {
    let id = UUID()
    let image: UIImage
    let title: String
}

struct ShopBestProductModel: Identifiable {
    let id = UUID()
    let image: UIImage
    let title: String
}

struct ShopNewProductModel: Identifiable {
    let id = UUID()
    let image: UIImage
    let title: String
}


