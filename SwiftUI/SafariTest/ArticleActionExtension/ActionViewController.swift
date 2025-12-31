//
//  ActionViewController.swift
//  ArticleActionExtension
//
//  Created by 이승진 on 10/13/25.
//

import UIKit
import UniformTypeIdentifiers

/// NOTE:
/// - preprocess.js 가 arguments.completionFunction(...) 으로
///   { url: String, highlights: [{ sentence, color, memo }...] } 형태를 넘겨줍니다.
/// - 여기서 App Group에 병합 저장하고, finalize payload로 Safari 페이지에 즉시 반영합니다.
final class ActionViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    handleIncomingData()
  }

  // MARK: - Entry
  private func handleIncomingData() {
    guard let item = extensionContext?.inputItems.first as? NSExtensionItem,
          let providers = item.attachments, !providers.isEmpty else {
      print("❌ No input item")
      complete()
      return
    }

    // 보통 첫 provider가 property-list를 갖고 있음
    // 혹시 몰라 전부 순회하며 첫 성공 시 종료
    for provider in providers {
      if tryLoadPropertyList(from: provider) { return }
    }

    print("❌ provider doesn’t have propertyList")
    complete()
  }

  // MARK: - Load property-list (from preprocess.js)
  @discardableResult
  private func tryLoadPropertyList(from provider: NSItemProvider) -> Bool {
    // iOS 14+ : UTType.propertyList.identifier == "com.apple.property-list"
    let identifiers = [UTType.propertyList.identifier, "com.apple.property-list"]

    for identifier in identifiers {
      if provider.hasItemConformingToTypeIdentifier(identifier) {
        print("📦 provider types:", provider.registeredTypeIdentifiers)
        provider.loadItem(forTypeIdentifier: identifier, options: nil) { [weak self] (dict, error) in
          guard let self = self else { return }

          if let error = error {
            print("❌ loadItem error:", error)
          }

          // dict 는 [String: Any] (또는 NSDictionary) 형태로 내려옴
          guard let root = dict as? [String: Any] else {
            print("❌ not dictionary:", String(describing: dict))
            self.complete()
            return
          }

          print("📥 JS payload root:", root)

          // 핵심: preprocess.js의 completionFunction(...) 이 넣어준 값
          //      NSExtensionJavaScriptPreprocessingResultsKey 하위에 존재
          let jsResult = root[NSExtensionJavaScriptPreprocessingResultsKey] as? [String: Any] ?? [:]
          print("📥 jsResult:", jsResult)

          // url, highlights 파싱 (하이라이트는 없어도 됨)
          let url = (jsResult["url"] as? String) ?? ""
          let arr = (jsResult["highlights"] as? [[String: Any]]) ?? []

          // SharedArticle.Highlight 로 변환
          let incomingHighlights: [SharedArticle.Highlight] = arr.compactMap { d in
            guard let sentence = d["sentence"] as? String else { return nil }
            let color = d["color"] as? String
            let memo  = d["memo"] as? String
            return .init(sentence: sentence, color: color, memo: memo)
          }

          // 병합 저장
          let incoming = SharedArticle(url: url, highlights: incomingHighlights)
          let merged = self.mergeAndSave(incoming)

          print("✅ 저장 완료:", merged.url, "(\(merged.highlights.count) highlights)")

          // Safari 페이지에 즉시 반영되도록 finalize payload 전달
          self.completeWithFinalize(url: merged.url, highlights: merged.highlights)
        }
        return true
      }
    }
    return false
  }

  // MARK: - Merge & Save (App Group)
  /// 기존 동일 URL 데이터가 있으면 sentence+color key 기준 병합.
  /// - 메모는 새 값이 있으면 덮어씀
  @discardableResult
  private func mergeAndSave(_ incoming: SharedArticle) -> SharedArticle {
    guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID) else {
      // App Group 미설정 시 fallback: 그대로 반환
      return incoming
    }

    var list = loadArticles(defaults: defaults)

    if let idx = list.firstIndex(where: { $0.url == incoming.url }) {
      var base = list[idx]

      // A안: (sentence+color, memo) 셋업 → in-place 업데이트 유지
      var existing = base.highlights
      for h in incoming.highlights {
        if let i = existing.firstIndex(where: { $0.sentence == h.sentence && ($0.color ?? "") == (h.color ?? "") }) {
          // 메모가 새로 왔고 비어있지 않다면 덮어쓰기
          if let newMemo = h.memo, !newMemo.isEmpty {
            existing[i] = .init(sentence: existing[i].sentence, color: existing[i].color, memo: newMemo)
          }
        } else {
          existing.append(h)
        }
      }
      base.highlights = existing
      list[idx] = base

    } else {
      list.append(incoming)
    }

    if let encoded = try? JSONEncoder().encode(list) {
      defaults.set(encoded, forKey: SharedConstants.storeKey)
    }

    // 반환은 최신 병합 결과
    return list.first(where: { $0.url == incoming.url }) ?? incoming
  }

  private func loadArticles(defaults: UserDefaults) -> [SharedArticle] {
    guard let data = defaults.data(forKey: SharedConstants.storeKey),
          let list = try? JSONDecoder().decode([SharedArticle].self, from: data) else {
      return []
    }
    return list
  }

  // MARK: - Complete (Finalizing with JS)
  /// Safari가 finalize 단계에서 페이지 컨텍스트로 주입할 데이터 전달
    private func completeWithFinalize(url: String, highlights: [SharedArticle.Highlight]) {
        let jsHi: [[String: Any]] = highlights.map { h in
            ["sentence": h.sentence, "color": h.color ?? "what", "memo": h.memo ?? ""]
        }
        let finalizePayload: [String: Any] = [
            "url": url,
            "highlights": jsHi
        ]
        
        // ✅ finalize 인자는 `com.apple.property-list` NSItemProvider 안에
        //    "NSExtensionJavaScriptFinalizeArgument" 키로 넣어 전달해야 함
        let payload = [NSExtensionJavaScriptFinalizeArgumentKey: finalizePayload] as NSDictionary
        let provider = NSItemProvider(item: payload, typeIdentifier: UTType.propertyList.identifier)
        
        let item = NSExtensionItem()
        item.attachments = [provider]
        
        extensionContext?.completeRequest(returningItems: [item], completionHandler: nil)
    }

  private func complete() {
    extensionContext?.completeRequest(returningItems: nil)
  }
}
