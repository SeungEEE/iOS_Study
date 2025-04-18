//
//  StarProgressBar.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/7/25.
//

import SwiftUI

struct StarProgressBar: View {
    var currentStars: Int
    var maxStars: Int

    private var progress: CGFloat {
        CGFloat(currentStars) / CGFloat(maxStars)
    }

    var body: some View {
        VStack(alignment: .trailing) {
            Button {
                print("내용 보기 탭됨")
            } label: {
                Text("내용 보기 →")
                    .font(.pretend(type: .regular, size: 13))
                    .foregroundColor(.gray06)
            }
            
            HStack {
                leftView
                
                Spacer()
                
                rightView
            }
        }
    }
    
    /// 남은 별 갯수 + 프로그레스바
    private var leftView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(maxStars - currentStars)★ until next Reward")
                .font(.mainTextSemiBold16)
                .foregroundColor(.brown01)
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(height: 8)
                        .foregroundColor(Color.gray.opacity(0.3))
                    
                    Capsule()
                        .frame(width: geo.size.width * progress, height: 8)
                        .foregroundColor(.brown01)
                }
            }
            .frame(height: 8)
        }
    }
    
    /// 내용보기 버튼 + 채운 별 갯수 보여주기
    private var rightView: some View {
        VStack(alignment: .trailing, spacing: 4) {
            HStack {
                Text("\(currentStars)")
                    .font(.pretend(type: .semiBold, size: 38))
                    .foregroundColor(.black)
                
                Text("/")
                    .font(.pretend(type: .light, size: 24))
                    .foregroundStyle(.gray00)

                Text("\(maxStars)★")
                    .font(.pretend(type: .semiBold, size: 24))
                    .foregroundColor(.brown01)
            }
        }
    }
}


#Preview {
    StarProgressBar(currentStars: 3, maxStars: 12)
}
