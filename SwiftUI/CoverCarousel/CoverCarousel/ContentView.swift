//
//  ContentView.swift
//  CoverCarousel
//
//  Created by 이승진 on 4/6/25.
//

import SwiftUI

struct ContentView: View {
    /// Since my model ID type is UUID
    @State private var activeID: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomCarousel(config: .init(hasOpacity: true, hasScale: true, cardWidth: 200, mininumCardWidth: 30), selection: $activeID, data: images) { item in
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(height: 180)
            }
            .navigationTitle("Cover Carousel")
        }
    }
}

#Preview {
    ContentView()
}
