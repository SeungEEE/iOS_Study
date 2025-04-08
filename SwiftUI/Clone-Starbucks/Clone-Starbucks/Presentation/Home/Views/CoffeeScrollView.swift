//
//  CoffeeScrollView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/7/25.
//

import SwiftUI

struct CoffeeScrollView: View {
    let coffeeCards: [CoffeeCardModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(coffeeCards) { card in
                    NavigationLink(value: card.coffeeId) {
                        VStack(alignment: .center) {
                            Image(uiImage: card.coffeeImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 130, height: 130)
                                .clipped()
                            
                            Text(card.title)
                                .font(.pretend(type: .semiBold, size: 14))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .frame(height: 160)
        }
    }
}

