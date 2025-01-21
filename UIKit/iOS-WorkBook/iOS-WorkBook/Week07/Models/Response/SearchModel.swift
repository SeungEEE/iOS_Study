//
//  SearchModel.swift
//  iOS-WorkBook
//
//  Created by 이승진 on 1/17/25.
//

import Foundation

struct SearchModel: Codable {
    let documents: [DetailDocument]
}

struct DetailDocument: Codable {
    let contents: String
    let datetime: String
    let title: String
    let url: String
}
