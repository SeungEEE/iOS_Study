//
//  SafariWebExtensionHandler.swift
//  SafariTest Extension
//
//  Created by 이승진 on 9/20/25.
//

import SafariServices

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {
    func beginRequest(with context: NSExtensionContext) {
        guard let item = context.inputItems.first as? NSExtensionItem,
              let message = item.userInfo?["message"] as? [String: Any],
              let url = message["url"] as? String,
              let highlightsData = try? JSONSerialization.data(withJSONObject: message["highlights"] ?? []) else {
            context.completeRequest(returningItems: nil, completionHandler: nil)
            return
        }

        do {
            let decoder = JSONDecoder()
            let highlights = try decoder.decode([SharedArticle.Highlight].self, from: highlightsData)
            let article = SharedArticle(url: url, highlights: highlights)
            saveToAppGroup(article)
            print("✅ 하이라이트 포함 기사 저장 완료:", article.url)
        } catch {
            print("❌ 하이라이트 디코딩 실패:", error)
        }

        context.completeRequest(returningItems: nil, completionHandler: nil)
    }

    private func saveToAppGroup(_ article: SharedArticle) {
        guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID) else { return }
        var list = loadAllArticles()
        list.append(article)
        if let data = try? JSONEncoder().encode(list) {
            defaults.set(data, forKey: "sharedArticles")
        }
    }

    private func loadAllArticles() -> [SharedArticle] {
        guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID),
              let data = defaults.data(forKey: "sharedArticles"),
              let list = try? JSONDecoder().decode([SharedArticle].self, from: data)
        else { return [] }
        return list
    }
}
