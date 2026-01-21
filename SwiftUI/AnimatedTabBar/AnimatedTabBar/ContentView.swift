//
//  ContentView.swift
//  AnimatedTabBar
//
//  Created by 이승진 on 1/20/26.
//

import SwiftUI

enum AppTab: AnimatedTabSelectionProtocol {
  case call
  case notification
  case settings
  
  var symbolImage: String {
    switch self {
    case .call: return "phone.down.waves.left.and.right"
    case .notification: return "bell.badge"
    case .settings: return "gearshape.fill"
    }
  }
  
  var title: String {
    switch self {
    case .call: return "Call"
    case .notification: return "Notification"
    case .settings: return "Settings"
    }
  }
}

struct ContentView: View {
  @State private var activeTab: AppTab = .call
  var body: some View {
    AnimatedTabView(selection: $activeTab) {
      Tab.init(AppTab.call.title, systemImage: AppTab.call.symbolImage, value: .call) {
        Text("Call")
      }
      
      Tab.init(AppTab.notification.title, systemImage: AppTab.notification.symbolImage, value: .notification) {
        Text("Notification")
      }
      
      Tab.init(AppTab.settings.title, systemImage: AppTab.settings.symbolImage, value: .settings) {
        Text("Settings")
      }
    } effects: { tab in
      switch tab {
      case .call: [.bounce.up]
      case .notification: [.wiggle]
      case .settings: [.rotate]
      }
    }
  }
}

#Preview {
  ContentView()
}
