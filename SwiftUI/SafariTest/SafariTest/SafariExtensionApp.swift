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
        .onOpenURL { url in
          guard let comps = URLComponents(url: url, resolvingAgainstBaseURL: true),
                comps.host == "share",
                let dataParam = comps.queryItems?.first(where: { $0.name == "data" })?.value,
                let decodedDataString = dataParam.removingPercentEncoding,
                let jsonData = Data(base64Encoded: decodedDataString)
          else {
            print("❌ 잘못된 공유 데이터")
            return
          }
          
          do {
            let article = try JSONDecoder().decode(SharedArticle.self, from: jsonData)
            sharedArticle = article
            print("✅ 공유받은 기사:", article.url)
          } catch {
            print("❌ 디코딩 실패:", error)
          }
        }
    }
  }
}
