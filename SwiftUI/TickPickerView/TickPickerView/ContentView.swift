//
//  ContentView.swift
//  TickPickerView
//
//  Created by 이승진 on 1/4/26.
//

import SwiftUI

struct ContentView: View {
  @State private var selection: Int = 0
  var body: some View {
    NavigationStack {
      VStack {
        TickPicker(count: 100, selection: $selection)
      }
    }
    .navigationTitle("Tick Picker")
  }
}

#Preview {
  ContentView()
}
