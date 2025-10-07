//
//  SavedArticle.swift
//  SafariTest
//
//  Created by 이승진 on 10/5/25.
//

import Foundation

struct SavedArticle: Codable, Identifiable, Hashable {
  var id: String
  var url: String
  var title: String
  var category: String?
  var note: String?
  var savedAt: Date
}
