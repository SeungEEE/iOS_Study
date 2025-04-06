//
//  ImageModel.swift
//  CoverCarousel
//
//  Created by 이승진 on 4/6/25.
//

import SwiftUI

struct ImageModel: Identifiable {
    var id: UUID = .init()
    var image: String
}

var images: [ImageModel] = (1...8).compactMap({ ImageModel(image: "Profile \($0)") })
