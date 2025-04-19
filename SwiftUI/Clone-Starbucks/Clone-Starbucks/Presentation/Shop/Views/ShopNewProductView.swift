//
//  ShopNewProductView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/15/25.
//

import SwiftUI

struct ShopNewProductView: View {
    let newProducts: [ShopNewProductModel]
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("New Products")
                .font(.mainTextBold24)
                .foregroundStyle(.black)
            
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(newProducts) { product in
                        VStack (alignment: .leading, spacing: 12){
                            Image(uiImage: product.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipped()
                                .frame(width: 150, height: 150)
                            Text(product.title)
                                .font(.pretend(type: .semiBold, size: 14))
                                .foregroundStyle(.black)
                                .frame(width: 150)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
        }
    }
}
