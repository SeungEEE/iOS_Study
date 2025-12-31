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
  @State private var presentingEditor: SharedArticle?
  
  var body: some View {
    NavigationView {
      List {
        if savedArticles.isEmpty {
          Text("저장된 기사 없음")
        } else {
          ForEach(savedArticles.reversed()) { article in
            Section {
              Button {
                presentingEditor = article
              } label: {
                VStack(alignment: .leading, spacing: 6) {
                  Text(article.url)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .underline()
                  if !article.highlights.isEmpty {
                    ForEach(article.highlights, id: \.self) { h in
                      VStack(alignment: .leading, spacing: 2) {
                        Text(h.sentence)
                          .padding(4)
                          .background(highlightColor(for: h.color))
                          .cornerRadius(4)
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
            }
          }
          .onDelete(perform: deleteArticle)
        }
      }
      .task {
        savedArticles = loadArticles()
      }
      .task(id: sharedArticle) {
        guard let article = sharedArticle else { return }
        saveArticle(article)
        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          sharedArticle = nil
        }
      }
      .overlay(alignment: .bottom) {
        if showToast {
          Text("저장 완료 ✅")
            .padding(8)
            .background(.ultraThinMaterial, in: Capsule())
            .onAppear {
              DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation { showToast = false }
              }
            }
        }
      }
      .navigationTitle("뉴BI스TOP")
      .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
        savedArticles = loadArticles()     // 🔄 App Group에서 최신 목록 리로드
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
  private func deleteArticle(at offsets: IndexSet) {
    guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID) else { return }
    var list = loadArticles()
    list.remove(atOffsets: offsets)
    if let encoded = try? JSONEncoder().encode(list) {
      defaults.set(encoded, forKey: "sharedArticles")
    }
    savedArticles = list
  }
  
  private func highlightColor(for token: String?) -> Color {
    switch token {
    case "what": return Color(red: 1.0, green: 0.91, blue: 0.84)
    case "why": return Color(red: 0.95, green: 1.0, blue: 0.85)
    case "detail": return Color(red: 0.85, green: 0.96, blue: 1.0)
    default: return .gray.opacity(0.2)
    }
  }
  
  private func saveArticle(_ article: SharedArticle) {
    guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID) else { return }
    var list = loadArticles()
    list.append(article)
    if let encoded = try? JSONEncoder().encode(list) {
      defaults.set(encoded, forKey: "sharedArticles")
    }
    savedArticles = list
  }
  
  private func loadArticles() -> [SharedArticle] {
    guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID),
          let data = defaults.data(forKey: "sharedArticles"),
          let list = try? JSONDecoder().decode([SharedArticle].self, from: data)
    else { return [] }
    return list
  }
  
  private func replaceHighlightsFromEditor(url: String, newHighlights: [SharedArticle.Highlight]) {
    guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID) else { return }
    var list = loadArticles()
    
    if let idx = list.firstIndex(where: { $0.url == url }) {
      var base = list[idx]
      // 에디터 결과로 완전히 교체
      base.highlights = dedup(newHighlights)
      list[idx] = base
    } else {
      // 없으면 새로 추가
      list.append(SharedArticle(url: url, highlights: dedup(newHighlights)))
    }
    
    if let encoded = try? JSONEncoder().encode(list) {
      defaults.set(encoded, forKey: SharedConstants.storeKey)
    }
  }
  
  // 중복 제거(문장+색 조합 기준, memo는 마지막 값 유지)
  private func dedup(_ arr: [SharedArticle.Highlight]) -> [SharedArticle.Highlight] {
    var seen = Set<String>()
    var out: [SharedArticle.Highlight] = []
    for h in arr {
      let key = h.sentence + "||" + (h.color ?? "")
      if seen.insert(key).inserted {
        out.append(h)
      } else {
        // 같은 키가 또 오면 뒤에 온 걸로 메모 갱신
        if let idx = out.firstIndex(where: { $0.sentence == h.sentence && ($0.color ?? "") == (h.color ?? "") }) {
          out[idx] = .init(sentence: h.sentence, color: h.color, memo: h.memo)
        }
      }
    }
    return out
  }
  
  private func mergeAndSave(_ incoming: SharedArticle) {
    guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID) else { return }
    var list = loadArticles()
    
    // 키 만들기: "sentence|color"
    func key(for h: SharedArticle.Highlight) -> String {
      let c = h.color ?? ""
      return "\(h.sentence)|\(c)"
    }
    
    if let idx = list.firstIndex(where: { $0.url == incoming.url }) {
      var base = list[idx]
      
      // 1) 기존 하이라이트를 "기존 순서"대로 유지하면서 맵을 만든다.
      var map: [String: SharedArticle.Highlight] = [:]
      base.highlights.forEach { map[key(for: $0)] = $0 }
      
      print("— before merge —")
      base.highlights.enumerated().forEach { i, h in
        print("  [\(i)] \(h.sentence.prefix(20))… | color=\(h.color ?? "") | memo=\(h.memo ?? "")")
      }
      
      // 2) 들어온 항목들을 반영
      //    - 같은 키면 memo가 비어있지 않을 때만 덮어씀
      //    - 새로운 키면 나중에 append를 위해 따로 모아둠
      var newOnes: [SharedArticle.Highlight] = []
      for h in incoming.highlights {
        let k = key(for: h)
        if var exist = map[k] {
          if let memo = h.memo, !memo.isEmpty {
            exist = .init(sentence: exist.sentence, color: exist.color, memo: memo)
            map[k] = exist
          }
        } else {
          map[k] = h
          newOnes.append(h) // 기존엔 없던 신규 항목(추가 순서 보존)
        }
      }
      
      // 3) 최종 배열 만들기
      //    - 기존 순서를 유지하며 업데이트된 값들로 다시 채우고,
      //    - 신규는 뒤에 append (incoming 순서 유지)
      var merged: [SharedArticle.Highlight] = []
      merged.reserveCapacity(map.count)
      
      for old in base.highlights {
        if let updated = map[key(for: old)] {
          merged.append(updated)
        }
      }
      merged.append(contentsOf: newOnes)
      
      print("— after merge —")
      merged.enumerated().forEach { i, h in
        print("  [\(i)] \(h.sentence.prefix(20))… | color=\(h.color ?? "") | memo=\(h.memo ?? "")")
      }
      
      base.highlights = merged
      list[idx] = base
    } else {
      // 새 URL이면 그대로 추가
      list.append(incoming)
    }
    
    if let encoded = try? JSONEncoder().encode(list) {
      defaults.set(encoded, forKey: SharedConstants.storeKey)
    }
  }
  
  private func openInSafari(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    UIApplication.shared.open(url)
  }
}
