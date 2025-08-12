//
//  ShopProductView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/13/25.
//

import SwiftUI

struct ShopProductView: View {
    let allProducts: [ShopProductModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("All Products")
                .font(.mainTextBold24)
                .foregroundStyle(.black)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 17) {
                    ForEach(allProducts) { product in
                        VStack(alignment: .center, spacing: 10) {
                            Image(uiImage: product.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipped()
                            Text(product.title)
                                .font(.pretend(type: .semiBold, size: 13))
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
            .frame(height: 108)
        }
    }
}
