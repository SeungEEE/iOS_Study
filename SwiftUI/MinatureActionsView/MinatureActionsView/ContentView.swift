//
//  ContentView.swift
//  MinatureActionsView
//
//  Created by 이승진 on 12/31/25.
//

import SwiftUI

struct ContentView: View {
  @State private var isPresented: Bool = false
  var body: some View {
    NavigationStack {
      List {
        NavigationLink("iPhone Guide") {
          
        }
        
        NavigationLink("iPad Guide") {
          
        }
      }
      .navigationTitle("Apple Books")
    }
    .overlay {
      MiniatureAction(animation: animation, isPresented: $isPresented) {
        ActionContent()
      } background: {
        ZStack {
          Capsule()
            .fill(.background)
          Capsule()
            .fill(.ultraThinMaterial)
        }
        .shadow(color: .gray.opacity(0.5), radius: 1)
      }
    }
  }
  
  @ViewBuilder
  func ActionContent() -> some View {
    VStack(spacing: 10) {
      CustomButton(title: "Search Book", symbol: "magnifyingglass")
        .frame(width: 250, height: 45)
      CustomButton(title: "Themes & Setting", symbol: "textformat.size")
        .frame(width: 250, height: 45)
      
      /// Horizontal Actions
      HStack(spacing: 10) {
        CustomSectionButton(symbol: "square.and.arrow.up")
        CustomSectionButton(symbol: "lock.rotation")
        CustomSectionButton(symbol: "text.line.magnify")
        CustomSectionButton(symbol: "bookmark")
      }
      .font(.title3)
      .fontWeight(.medium)
      .frame(width: 250, height: 50)
    }
    .foregroundStyle(.primary)
  }
  
  var animation: Animation {
    .smooth(duration: 0.5, extraBounce: 0)
  }
}

/// Custom Buttons
struct CustomButton: View {
  var title: String
  var symbol: String
  var action: () -> () = {}
  var body: some View {
    Button(action: action) {
      HStack(spacing: 10) {
        Text(title)
        Spacer(minLength: 0)
        Image(systemName: symbol)
      }
      .padding(.horizontal, 20)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(.background, in: .capsule)
    }
  }
}

struct CustomSectionButton: View {
  var symbol: String
  var action: () -> () = {}
  var body: some View {
    Button(action: action) {
      Image(systemName: symbol)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background, in: .capsule
        )
    }
  }
}

#Preview {
  ContentView()
}
