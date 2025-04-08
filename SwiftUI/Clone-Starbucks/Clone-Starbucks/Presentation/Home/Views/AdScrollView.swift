//
//  AdScrollView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/7/25.
//

import SwiftUI

struct AdScrollView: View {
    let adCards: [AdBannerModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(adCards) { card in
                    VStack(alignment: .leading, spacing: 10) {
                        Image(uiImage: card.adImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 242, height: 160)
                            .clipped()
                            .cornerRadius(5)
                        
                        Text(card.title)
                            .font(.pretend(type: .semiBold, size: 18))
                            .foregroundColor(.black)
                        
                        Text(card.description)
                            .font(.pretend(type: .semiBold, size: 13))
                            .foregroundColor(.gray03)
                            .frame(maxWidth: 235, alignment: .leading)
                    }
                }
            }
            .frame(height: 249)
        }
    }
}

#Preview {
    AdScrollView(adCards: [.init(adImage: .ad01, title: "g", description: "g")])
}
