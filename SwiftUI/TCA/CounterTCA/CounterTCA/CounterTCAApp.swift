//
//  CounterTCAApp.swift
//  CounterTCA
//
//  Created by 이승진 on 2/24/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct CounterTCAApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(initialState: CounterFeature.State()) {
                    CounterFeature()
                }
            )
        }
    }
}
