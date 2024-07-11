//
//  PageModel.swift
//  Pinch
//
//  Created by 이승진 on 2024/07/11.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
