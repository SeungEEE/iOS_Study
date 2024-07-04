//
//  CustomCircleView.swift
//  Hike
//
//  Created by 이승진 on 2024/07/03.
//

import SwiftUI

struct CustomCircleView: View {
    @State private var isAnimateGraient: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            .customIndigoMedium,
                            .customSalmonLight
                        ],
                        startPoint: isAnimateGraient ? .topLeading : .bottomLeading,
                        endPoint: isAnimateGraient ? .bottomTrailing : .topTrailing
                    )
                )
                .onAppear {
                    withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: true)) {
                        isAnimateGraient.toggle()
                    }
                }
            MotionAnimationView()
            
        } //: ZSTACK
        .frame(width: 256, height: 256)
    }
}

#Preview {
    CustomCircleView()
}
