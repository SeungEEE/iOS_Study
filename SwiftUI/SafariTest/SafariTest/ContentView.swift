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
  
  var body: some View {
    NavigationView {
      List {
        if savedArticles.isEmpty {
          Text("저장된 기사 없음")
        } else {
          ForEach(savedArticles.reversed()) { article in
            Section {
              Button {
                openInSafari(urlString: article.url)
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
    }
  }
  
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
  
  private func openInSafari(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    UIApplication.shared.open(url)
  }
}
