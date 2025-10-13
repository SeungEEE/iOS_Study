//
//  SafariExtensionApp.swift
//  SafariTest
//
//  Created by 이승진 on 9/20/25.
//

import SwiftUI

@main
struct SafariExtensionApp: App {
  @State private var sharedArticle: SharedArticle?
  
  var body: some Scene {
    WindowGroup {
      ContentView(sharedArticle: $sharedArticle)
        .onOpenURL  { url in
          guard url.host == "share",
                let dataParam = url.queryItems["data"] else { return }
          
          if let decodedData = Data(base64Encoded: dataParam),
             let article = try? JSONDecoder().decode(SharedArticle.self, from: decodedData) {
            sharedArticle = article
            print("✅ 공유받은 기사:", article.url)
          } else {
            print("❌ 공유 데이터 파싱 실패")
          }
        }
    }
  }
}

extension URL {
  var queryItems: [String: String] {
    URLComponents(url: self, resolvingAgainstBaseURL: false)?
      .queryItems?
      .reduce(into: [:]) { $0[$1.name] = $1.value } ?? [:]
  }
}
