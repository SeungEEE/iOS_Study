//
//  ContentView.swift
//  HorizontalWheelPicker
//
//  Created by 이승진 on 7/16/25.
//

import SwiftUI

struct ContentView: View {
    @State private var config: WheelPicker.Config = .init(count: 30, steps: 5, spacing: 15, multiplier: 10)
    @State private var value: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .lastTextBaseline, spacing: 5) {
                    Text(verbatim: "\(value)")
                        .font(.largeTitle.bold())
                        .contentTransition(.numericText(value: value))
                        .animation(.snappy, value: value)
                    
                    Text("lbs")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
                }
                .padding(.bottom, 30)
                
                WheelPicker(config: config, value: $value)
                    .frame(height: 60)
            }
            .navigationTitle("WheelPicker")
        }
    }
}

#Preview {
    ContentView()
}
