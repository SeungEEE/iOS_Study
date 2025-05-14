//
//  OrderModel.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/29/25.
//

import SwiftUI

struct OrderModel: Identifiable {
    let id = UUID()
    let name: String
    let nameEnglish: String
    let image: UIImage
    
    init(name: String, nameEnglish: String, image: UIImage) {
        self.name = name
        self.nameEnglish = nameEnglish
        self.image = image
    }
}
