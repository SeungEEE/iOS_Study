//
//  SharedArticle.swift
//  SafariTest
//
//  Created by 이승진 on 10/10/25.
//

import Foundation

struct SharedArticle: Codable, Identifiable, Hashable {
    let id: UUID
    let url: String
    var highlights: [Highlight]
    var createdAt: Date

    struct Highlight: Codable, Hashable {
        let sentence: String
        let color: String?
        let memo: String?
    }

    init(url: String, highlights: [Highlight]) {
        self.id = UUID()
        self.url = url
        self.highlights = highlights
        self.createdAt = Date()
    }
}
