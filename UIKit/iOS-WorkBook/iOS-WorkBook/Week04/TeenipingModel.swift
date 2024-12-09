//
//  TeenipingModel.swift
//  iOS-WorkBook
//
//  Created by 이승진 on 12/9/24.
//

import UIKit

struct TeenipingModel {
    let image: UIImage
    let name: String
}

extension TeenipingModel {
    static func dumy() -> [TeenipingModel] {
        return [
            TeenipingModel(image: .hachuping, name: "하츄핑"),
            TeenipingModel(image: .lalaping, name: "라라핑"),
            TeenipingModel(image: .baroping, name: "바로핑"),
            TeenipingModel(image: .azaping, name: "아자핑"),
            TeenipingModel(image: .chachaping, name: "차차핑"),
            TeenipingModel(image: .haeping, name: "해핑"),
            TeenipingModel(image: .mugaping, name: "무거핑"),
            TeenipingModel(image: .siroping, name: "시러핑")
        ]
    }
}
