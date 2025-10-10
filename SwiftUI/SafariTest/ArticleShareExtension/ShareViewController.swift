import UIKit
import UniformTypeIdentifiers

final class ShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("✅ Share Extension Loaded")
        handleIncomingItems()
    }

    private func handleIncomingItems() {
        guard let item = extensionContext?.inputItems.first as? NSExtensionItem,
              let attachments = item.attachments else {
            completeRequest()
            return
        }

        for provider in attachments {
            // ✅ URL 타입도 처리해야 함
            if provider.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
                provider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil) { item, _ in
                    if let url = item as? URL {
                        print("✅ 공유받은 URL:", url.absoluteString)
                        let article = SharedArticle(
                            url: url.absoluteString,
                            highlights: []
                        )
                        self.saveToAppGroup(article)
                        self.showAlert(title: "저장 완료 ✅", message: "링크가 저장되었습니다.")
                    }
                    self.completeRequest()
                }
            }
            // (선택) 텍스트도 함께 처리하고 싶으면 아래 유지
            else if provider.hasItemConformingToTypeIdentifier(UTType.plainText.identifier) {
                provider.loadItem(forTypeIdentifier: UTType.plainText.identifier, options: nil) { item, _ in
                    if let text = item as? String,
                       let url = URL(string: text) {
                        print("✅ 공유받은 텍스트 URL:", text)
                        let article = SharedArticle(
                            url: url.absoluteString,
                            highlights: []
                        )
                        self.saveToAppGroup(article)
                        self.showAlert(title: "저장 완료 ✅", message: "링크가 저장되었습니다.")
                    }
                    self.completeRequest()
                }
            }
        }
    }

    private func saveToAppGroup(_ article: SharedArticle) {
        guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID) else {
            print("❌ App Group 접근 실패")
            return
        }
        var saved = loadSavedArticles()
        saved.append(article)
        if let encoded = try? JSONEncoder().encode(saved) {
            defaults.set(encoded, forKey: "sharedArticles")
            print("📦 App Group에 저장됨:", article.url)
        }
    }

    private func loadSavedArticles() -> [SharedArticle] {
        guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID),
              let data = defaults.data(forKey: "sharedArticles"),
              let list = try? JSONDecoder().decode([SharedArticle].self, from: data)
        else { return [] }
        return list
    }

    private func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            self.present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                alert.dismiss(animated: true)
            }
        }
    }

    private func completeRequest() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
}
