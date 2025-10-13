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
              let attachments = item.attachments, !attachments.isEmpty else {
            completeRequest(); return
        }

        let group = DispatchGroup()
        var savedSomething = false

        for provider in attachments {
            // 1) ASJSON:… 이 담긴 텍스트 먼저 시도
            if provider.hasItemConformingToTypeIdentifier(UTType.plainText.identifier) {
                group.enter()
                provider.loadItem(forTypeIdentifier: UTType.plainText.identifier, options: nil) { item, _ in
                    defer { group.leave() }
                    guard let text = item as? String else { return }
                    if let article = self.decodeArticle(fromSharedText: text) {
                        self.saveToAppGroup(article)
                        savedSomething = true
                    } else if let url = URL(string: text) {
                        // 텍스트가 단순 URL이면 URL만 저장
                        let a = SharedArticle(url: url.absoluteString, highlights: [])
                        self.saveToAppGroup(a)
                        savedSomething = true
                    }
                }
                continue
            }

            // 2) URL 타입 처리
            if provider.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
                group.enter()
                provider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil) { item, _ in
                    defer { group.leave() }
                    guard let url = item as? URL else { return }
                    let a = SharedArticle(url: url.absoluteString, highlights: [])
                    self.saveToAppGroup(a)
                    savedSomething = true
                }
                continue
            }
        }

        group.notify(queue: .main) {
            if savedSomething {
                self.quickToast("저장 완료 ✅")
            }
            self.completeRequest()
        }
    }

    // MARK: - WebPayload → SharedArticle 변환
    private struct WebPayload: Codable {
        struct Highlight: Codable {
            let sentence: String
            let color: String?
            let memo: String?
        }
        let url: String
        let highlights: [Highlight]
    }

    private func decodeArticle(fromSharedText text: String) -> SharedArticle? {
        guard let range = text.range(of: "ASJSON:") else { return nil }
        let base64 = String(text[range.upperBound...]).trimmingCharacters(in: .whitespacesAndNewlines)
        guard let data = Data(base64Encoded: base64) else { return nil }
        do {
            let payload = try JSONDecoder().decode(WebPayload.self, from: data)
            let highlights = payload.highlights.map {
                SharedArticle.Highlight(sentence: $0.sentence, color: $0.color, memo: $0.memo)
            }
            return SharedArticle(url: payload.url, highlights: highlights)
        } catch {
            print("❌ WebPayload 디코딩 실패:", error)
            return nil
        }
    }

    // MARK: - 저장/마무리
    private func saveToAppGroup(_ article: SharedArticle) {
        guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID) else {
            print("❌ App Group 접근 실패"); return
        }
        var list = loadSavedArticles()
        list.append(article)
        if let encoded = try? JSONEncoder().encode(list) {
            defaults.set(encoded, forKey: SharedConstants.storeKey)
            print("📦 App Group 저장:", article.url, "하이라이트:", article.highlights.count)
        }
    }

    private func loadSavedArticles() -> [SharedArticle] {
        guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID),
              let data = defaults.data(forKey: SharedConstants.storeKey),
              let list = try? JSONDecoder().decode([SharedArticle].self, from: data)
        else { return [] }
        return list
    }

    private func quickToast(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alert.dismiss(animated: true)
        }
    }

    private func completeRequest() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
}
