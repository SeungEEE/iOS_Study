//
//  ContentView.swift
//  TickPickerView
//
//  Created by 이승진 on 1/4/26.
//

import SwiftUI

struct ContentView: View {
  @State private var selection: Int = 5
  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        TickPicker(count: 100, config: config, selection: $selection)
        Text("\(selection)")
          .monospaced()
          .fontWeight(.medium)
        
        Button("Update to 20") {
          selection = 20
        }
      }
      .navigationTitle("Tick Picker")
    }
  }
  
  var config: TickConfig {
    return .init(
      tickWidth: 2,
      alignment: .bottom
    )
  }
}

#Preview {
  ContentView()
}
