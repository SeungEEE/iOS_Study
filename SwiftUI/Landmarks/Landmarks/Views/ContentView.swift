//
//  ContentView.swift
//  Landmarks
//
//  Created by 이승진 on 2024/07/03.
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
