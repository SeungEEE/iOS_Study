//
//  CategoryHome.swift
//  Landmarks
//
//  Created by 이승진 on 3/9/25.
//

import SwiftUI

struct CategoryHome: View {
    var body: some View {
        NavigationSplitView {
            Text("Hello")
                .navigationTitle("Featured")
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    CategoryHome()
}
