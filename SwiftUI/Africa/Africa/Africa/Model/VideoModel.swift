//
//  VideoModel.swift
//  Africa
//
//  Created by 이승진 on 10/10/24.
//

import Foundation

struct Video: Codable, Identifiable {
    let id: String
    let name: String
    let headline: String
    
    // Computer Property
    var thumbnail: String {
        "video-\(id)"
    }
}
