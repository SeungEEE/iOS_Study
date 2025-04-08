//
//  DessertScrollView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/7/25.
//

import SwiftUI

struct DessertScrollView: View {
    let dessertCards: [DessertCardModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(dessertCards) { card in
                    VStack(alignment: .center) {
                        Image(uiImage: card.dessertImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 130, height: 130)
                            .clipped()
                            .cornerRadius(12)
                        
                        Text(card.title)
                            .font(.pretend(type: .semiBold, size: 14))
                            .foregroundColor(.black)
                    }
                }
            }
            .frame(height: 160)
        }
    }
}

#Preview {
    DessertScrollView(dessertCards: [.init(dessertImage: .dessert01, title: "빵빵빵")])
}
