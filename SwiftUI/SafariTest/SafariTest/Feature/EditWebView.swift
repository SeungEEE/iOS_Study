//
//  EditWebView.swift
//  SafariTest
//
//  Created by 이안 on 10/13/25.
//

import SwiftUI
import UIKit

struct EditWebView: UIViewControllerRepresentable {
  let article: SharedArticle
  let onSave: (SharedArticle) -> Void
  let onCancel: () -> Void

  func makeUIViewController(context: Context) -> UINavigationController {
    let vc = EditWebViewController(article: article, onSave: onSave, onCancel: onCancel)
    let nav = UINavigationController(rootViewController: vc)
    nav.modalPresentationStyle = .fullScreen
    return nav
  }

  func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    // 필요 시 갱신 로직 (여기서는 없음)
  }
}
