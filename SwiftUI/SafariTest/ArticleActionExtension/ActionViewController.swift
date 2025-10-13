//
//  ActionViewController.swift
//  ArticleActionExtension
//
//  Created by 이승진 on 10/13/25.
//

import UIKit
import UniformTypeIdentifiers

final class ActionViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    handleIncomingData()
  }
  
  private func handleIncomingData() {
    guard let item = extensionContext?.inputItems.first as? NSExtensionItem,
          let itemProvider = item.attachments?.first else {
      print("❌ No input item")
      complete()
      return
    }

    print("📦 provider types:", itemProvider.registeredTypeIdentifiers)

    let type = UTType.propertyList.identifier
    if itemProvider.hasItemConformingToTypeIdentifier(type) {
      itemProvider.loadItem(forTypeIdentifier: type, options: nil) { (dict, error) in
        if let error = error { print("❌ loadItem error:", error) }

        guard let itemDict = dict as? [String: Any] else {
          print("❌ not dictionary:", String(describing: dict))
          self.complete(); return
        }

        print("📥 JS payload root:", itemDict)

        let jsResult = itemDict[NSExtensionJavaScriptPreprocessingResultsKey] as? [String: Any] ?? [:]
        print("📥 jsResult:", jsResult)

        guard let url = jsResult["url"] as? String,
              let highlightsArray = jsResult["highlights"] as? [[String: Any]] else {
          print("❌ 데이터 파싱 실패")
          self.complete(); return
        }

        let highlights = highlightsArray.compactMap { d -> SharedArticle.Highlight? in
          guard let sentence = d["sentence"] as? String else { return nil }
          return SharedArticle.Highlight(
            sentence: sentence,
            color: d["color"] as? String,
            memo: d["memo"] as? String
          )
        }

        let article = SharedArticle(url: url, highlights: highlights)
        self.saveToAppGroup(article)
        print("✅ 저장 완료:", article.url, "(\(highlights.count) highlights)")

        self.complete()
      }
    } else {
      print("❌ provider doesn’t have propertyList")
      complete()
    }
  }
  
  private func openMainApp(with article: SharedArticle) {
    guard let encoded = try? JSONEncoder().encode(article),
          let base64 = encoded.base64EncodedString().addingPercentEncoding(withAllowedCharacters: .alphanumerics),
          let url = URL(string: "articlescraper://share?data=\(base64)")
    else {
      print("❌ URL 인코딩 실패")
      return
    }
    
    var responder: UIResponder? = self
    while responder != nil {
      if let app = responder as? UIApplication {
        app.performSelector(onMainThread: Selector(("openURL:")), with: url, waitUntilDone: false)
        break
      }
      responder = responder?.next
    }
  }
  
  private func saveToAppGroup(_ article: SharedArticle) {
    guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID) else { return }
    var list = (try? JSONDecoder().decode([SharedArticle].self,
                                          from: defaults.data(forKey: SharedConstants.storeKey) ?? Data())) ?? []
    list.append(article)
    if let encoded = try? JSONEncoder().encode(list) {
      defaults.set(encoded, forKey: SharedConstants.storeKey)
    }
  }
  
  private func complete() {
    extensionContext?.completeRequest(returningItems: nil)
  }
}
