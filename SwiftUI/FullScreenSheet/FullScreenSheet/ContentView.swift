//
//  ContentView.swift
//  FullScreenSheet
//
//  Created by 이승진 on 1/15/26.
//

import SwiftUI

struct ContentView: View {
  @State private var showSheet: Bool = false
  @Namespace private var animation
  
  var body: some View {
    NavigationStack {
      List {
        Button("Show Sheet") {
          showSheet.toggle()
        }
        .matchedTransitionSource(id: "BUTTON", in: animation)
      }
      .navigationTitle("Full-Screen Sheet")
    }
    .fullScreenSheet(ignoreSafeArea: true, isPresented: $showSheet) { safeArea in
      List {
        ForEach(1...100, id: \.self) { index in
          Text("Dummy Row\(index)")
            .font(.title3)
            .fontWeight(.medium)
            .monospaced()
            .foregroundStyle(.white)
            .listRowBackground(Color.clear)
        }
      }
      .listStyle(.plain)
      .scrollContentBackground(.hidden)
      .safeAreaPadding(.top, safeArea.top)
//      .navigationTransition(.zoom(sourceID: "BUTTON", in: animation))
    } background: {
      ConcentricRectangle()
        .fill(.BG.gradient)
    }

  }
}

#Preview {
  ContentView()
}
