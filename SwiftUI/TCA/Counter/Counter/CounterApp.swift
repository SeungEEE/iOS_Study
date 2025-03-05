//
//  CounterApp.swift
//  Counter
//
//  Created by 이승진 on 10/2/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct CounterApp: App {
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
