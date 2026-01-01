//
//  ContentView.swift
//  SafariTest
//
//  Created by 이승진 on 9/20/25.
//

import SwiftUI

struct ContentView: View {
  @Binding var sharedArticle: SharedArticle?
  @State private var savedArticles: [SharedArticle] = []
  @State private var showToast = false
  @State private var presentEditor: SharedArticle?

  var body: some View {
    NavigationView {
      List {
        if savedArticles.isEmpty {
          Text("저장된 기사 없음")
            .foregroundColor(.secondary)
        } else {
          ForEach(savedArticles.indices, id: \.self) { idx in
            let article = savedArticles[idx]
            Section {
              VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                  Button {
                    openInSafari(urlString: article.url)
                  } label: {
                    Text(article.url)
                      .font(.subheadline)
                      .foregroundColor(.blue)
                      .underline()
                      .lineLimit(2)
                      .multilineTextAlignment(.leading)
                  }
                  Spacer(minLength: 8)
                  Button("편집") {
                    presentEditor = article
                  }
                  .buttonStyle(.bordered)
                  .font(.caption)
                }

                if !article.highlights.isEmpty {
                  VStack(alignment: .leading, spacing: 6) {
                    ForEach(article.highlights, id: \.self) { h in
                      VStack(alignment: .leading, spacing: 2) {
                        Text(h.sentence)
                          .padding(6)
                          .background(highlightColor(for: h.color))
                          .cornerRadius(6)
                        if let memo = h.memo, !memo.isEmpty {
                          Text("💬 \(memo)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        }
                      }
                    }
                  }
                }
              }
              // 스와이프 액션으로도 편집 가능
              .swipeActions(edge: .trailing) {
                Button("편집") { presentEditor = article }
                  .tint(.blue)
              }
            }
          }
          .onDelete(perform: deleteArticle)
        }
      }
      .navigationTitle("뉴BI스TOP")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            savedArticles = loadArticles()
          } label: { Image(systemName: "arrow.clockwise") }
        }
      }
      .task {
        savedArticles = loadArticles()
      }
      .task(id: sharedArticle) {
        guard let article = sharedArticle else { return }
        upsertArticle(article)            // 공유로 들어온 데이터 반영(병합)
        showToastOnce()
        sharedArticle = nil
      }
      .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
        savedArticles = loadArticles()    // 포그라운드 복귀 시 최신화
      }
      .overlay(alignment: .bottom) {
        if showToast {
          Text("저장 완료 ✅")
            .padding(10)
            .background(.ultraThinMaterial, in: Capsule())
            .padding(.bottom, 12)
            .transition(.opacity)
        }
      }
      // 편집기 표시
      .sheet(item: $presentEditor) { article in
        EditWebViewWrapper(
          article: article,
          onSave: { updated in
            upsertArticle(updated)        // 편집 결과 병합 저장
            showToastOnce()
          },
          onCancel: { /* no-op */ }
        )
        .ignoresSafeArea()
      }
      .sheet(item: $presentingEditor, onDismiss: {
        // 편집기 닫히면 최신 목록 반영
        savedArticles = loadArticles()
      }) { article in
        EditWebView(
          article: article,
          onSave: { updated in
            replaceHighlightsFromEditor(url: updated.url, newHighlights: updated.highlights)
            //                        presentingEditor = nil
            savedArticles = loadArticles()
          },
          onCancel: {
            presentingEditor = nil
          }
        )
        .ignoresSafeArea()
      }
    }
  }

  // MARK: - Helpers

  private func showToastOnce() {
    withAnimation { showToast = true }
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
      withAnimation { showToast = false }
    }
  }

  private func deleteArticle(at offsets: IndexSet) {
    guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID) else { return }
    var list = loadArticles()
    list.remove(atOffsets: offsets)
    if let encoded = try? JSONEncoder().encode(list) {
      defaults.set(encoded, forKey: SharedConstants.storeKey)
    }
    savedArticles = list
  }

  private func highlightColor(for token: String?) -> Color {
    switch token {
    case "what":   return Color(red: 1.0,  green: 0.91, blue: 0.84)
    case "why":    return Color(red: 0.95, green: 1.0,  blue: 0.85)
    case "detail": return Color(red: 0.85, green: 0.96, blue: 1.0)
    default:       return .gray.opacity(0.18)
    }
  }

  /// 공유/편집으로 들어온 기사를 URL 기준으로 upsert + 하이라이트 병합(중복제거)
  private func upsertArticle(_ incoming: SharedArticle) {
    guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID) else { return }
    var list = loadArticles()
    if let idx = list.firstIndex(where: { $0.url == incoming.url }) {
      // 기존 하이라이트와 병합+중복제거
      var merged = list[idx]
      merged.highlights = dedup(merged.highlights + incoming.highlights)
      merged.createdAt  = max(merged.createdAt, incoming.createdAt)
      list[idx] = merged
    } else {
      var fresh = incoming
      fresh.highlights = dedup(incoming.highlights)
      list.append(fresh)
    }
    if let encoded = try? JSONEncoder().encode(list) {
      defaults.set(encoded, forKey: SharedConstants.storeKey)
    }
    savedArticles = list
  }

  private func dedup(_ arr: [SharedArticle.Highlight]) -> [SharedArticle.Highlight] {
    var seen = Set<String>()
    var out: [SharedArticle.Highlight] = []
    for h in arr {
      let key = "\(h.sentence)|\(h.color ?? "")|\(h.memo ?? "")"
      if !seen.contains(key) {
        seen.insert(key)
        out.append(h)
      }
    }
    return out
  }

  private func saveArticle(_ article: SharedArticle) {
    // 기존 단순 append → 이제 upsert 사용 권장
    upsertArticle(article)
  }

  private func loadArticles() -> [SharedArticle] {
    guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID),
          let data = defaults.data(forKey: SharedConstants.storeKey),
          let list = try? JSONDecoder().decode([SharedArticle].self, from: data)
    else { return [] }
    return list
  }

  private func openInSafari(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    UIApplication.shared.open(url)
  }
}

// MARK: - EditWebViewWrapper (간단 래퍼)
// 실제 EditWebViewController는 네가 가진 구현 사용.
// 여기서는 sheet로 띄우기 위한 간단한 Representable만 제공.
import UIKit

struct EditWebViewWrapper: UIViewControllerRepresentable, Identifiable {
  let id = UUID()
  let article: SharedArticle
  let onSave: (SharedArticle) -> Void
  let onCancel: () -> Void

  func makeUIViewController(context: Context) -> UINavigationController {
    let vc = EditWebViewController(article: article, onSave: onSave, onCancel: onCancel)
    return UINavigationController(rootViewController: vc)
  }

  func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
