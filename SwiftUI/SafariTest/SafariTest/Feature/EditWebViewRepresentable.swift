//
//  EditWebViewRepresentable.swift
//  SafariTest
//
//  Created by 이승진 on 10/13/25.
//

import SwiftUI

struct EditWebViewRepresentable: UIViewControllerRepresentable {
  let article: SharedArticle
  func makeUIViewController(context: Context) -> UIViewController {
    UINavigationController(rootViewController: EditWebViewController(article: article))
  }
  func updateUIViewController(_ vc: UIViewController, context: Context) {}
}
