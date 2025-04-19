//
//  ShopTopScrollView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/13/25.
//

import SwiftUI

struct ShopTopScrollView: View {
    let topBanners: [ShopTopModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Starbucks Online Store")
                .font(.mainTextBold24)
                .foregroundStyle(.black)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 28) {
                    ForEach(topBanners) { banner in
                        Image(uiImage: banner.bannerImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 270)
                            .clipped()
                    }
                }
            }
            .frame(height: 216)
        }
    }
}
