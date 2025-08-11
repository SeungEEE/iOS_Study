//
//  BannerView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/11/25.
//

import SwiftUI

/// 배너 이미지 보여주는 뷰
struct BannerView: View {
    
    // MARK: - Property
    
    /// 표시할 이미지 리소스
    let image: ImageResource
    
    
    // MARK: - Body
    
    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    BannerView(image: .banner01)
}
