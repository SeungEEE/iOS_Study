//
//  ExtraSwiftDataApp.swift
//  ExtraSwiftData
//
//  Created by 이승진 on 4/9/25.
//

import SwiftUI
import SwiftData

@main
struct ExtraSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Task.self)
    }
}
