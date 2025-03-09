//
//  ContentView.swift
//  MacLandmarks
//
//  Created by 이승진 on 3/9/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
            .frame(minWidth: 700, minHeight: 300)
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
