//
//  ContentView.swift
//  WatchLandmarks Watch App
//
//  Created by 이승진 on 3/9/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
