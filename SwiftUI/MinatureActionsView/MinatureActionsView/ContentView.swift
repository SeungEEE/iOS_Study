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
    .overlay(alignment: .topLeading) {
      ZStack(alignment: .bottomTrailing) {
        Rectangle()
          .fill(.primary.opacity(isPresented ? 0.2 : 0))
          .allowsHitTesting(isPresented)
          .onTapGesture {
            isPresented = false
          }
          .animation(animation, value: isPresented)
          .ignoresSafeArea()
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
        .padding(.trailing, 15)
        .padding(.bottom, 10)
      }
    }
  }
  
  @ViewBuilder
  func ActionContent() -> some View {
    VStack(spacing: 10) {
      CustomButton(title: "Search Book", symbol: "magnifyingglass", isPresented: $isPresented)
        .frame(width: 250, height: 45)
      CustomButton(title: "Themes & Setting", symbol: "textformat.size", isPresented: $isPresented)
        .frame(width: 250, height: 45)
      
      /// Horizontal Actions
      HStack(spacing: 10) {
        CustomSectionButton(symbol: "square.and.arrow.up", isPresented: $isPresented)
        CustomSectionButton(symbol: "lock.rotation", isPresented: $isPresented)
        CustomSectionButton(symbol: "text.line.magnify", isPresented: $isPresented)
        CustomSectionButton(symbol: "bookmark", isPresented: $isPresented)
      }
      .font(.title3)
      .fontWeight(.medium)
      .frame(width: 250, height: 50)
    }
    .foregroundStyle(.primary)
  }
  
  var animation: Animation {
    .smooth(duration: 0.35, extraBounce: 0)
  }
}

/// Custom Buttons
struct CustomButton: View {
  var title: String
  var symbol: String
  @Binding var isPresented: Bool
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
      .opacity(isPresented ? 1 : 0)
      .background {
        ZStack {
          Rectangle()
            .fill(.primary)
            .opacity(isPresented ? 0 : 1)
          
          Rectangle()
            .fill(.background)
            .opacity(isPresented ? 1 : 0)
        }
        .clipShape(.capsule)
      }
    }
  }
}

struct CustomSectionButton: View {
  var symbol: String
  @Binding var isPresented: Bool
  var action: () -> () = {}
  var body: some View {
    Button(action: action) {
      Image(systemName: symbol)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(isPresented ? 1 : 0)
        .background {
          ZStack {
            Rectangle()
              .fill(.primary)
              .opacity(isPresented ? 0 : 1)
            
            Rectangle()
              .fill(.background)
              .opacity(isPresented ? 1 : 0)
          }
          .clipShape(.capsule)
        }
    }
  }
}

#Preview {
  ContentView()
}
