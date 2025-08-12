//
//  ShopView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/30/25.
//

import SwiftUI

struct ShopView: View {
    var viewModel: ShopViewModel = .init()
    
    var body: some View {
        
        ScrollView(.vertical) {
            VStack(spacing: 30) {
                /// 상단 배너 스크롤뷰
                ShopTopScrollView(topBanners: viewModel.topBanner)
                
                /// All Products View
                ShopProductView(allProducts: viewModel.allProducts)
                
                /// Best Item View
                ShopBestItemView(bestProducts: viewModel.bestProducts)
                
                /// New Products View
                ShopNewProductView(newProducts: viewModel.newProducts)
            }
        }
        .safeAreaPadding(EdgeInsets(top: 27, leading: 16, bottom: 50, trailing: 16))
        .background(.white01)
    }
}

#Preview {
    ShopView()
}
