//
//  ShopBestItemView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/14/25.
//

import SwiftUI

struct ShopBestItemView: View {
    let bestProducts: [ShopBestProductModel]
    
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    private var pagedProducts: [[ShopBestProductModel]] {
        stride(from: 0, to: bestProducts.count, by: 4).map {
            Array(bestProducts[$0..<min($0 + 4, bestProducts.count)])
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Best Items")
                .font(.mainTextBold24)
                .foregroundStyle(.black)
            
            TabView {
                ForEach(pagedProducts.indices, id: \.self) { index in
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(pagedProducts[index]) { product in
                            VStack(alignment: .leading, spacing: 12) {
                                Image(uiImage: product.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .frame(width: 150, height: 150)
                                Text(product.title)
                                    .font(.pretend(type: .semiBold, size: 14))
                                    .foregroundStyle(.black)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 150)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .frame(height: 480)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .padding(.bottom, 20)
        }
    }
}
