//
//  RewardProgressView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/11/25.
//

import SwiftUI

/// 리워드 진행률 프로그레스 뷰
struct RewardProgressView: View {
    
    // MARK: - Property
    
    /// 총 별 개수
    var totalStarCount: Int = 12
    
    /// 현재 획득한 별 개수
    var currentStarCount: Int = 1
    
    /// 리워드 문구
    var rewardText: String {
        "\(totalStarCount - currentStarCount)★ until next Reward"
    }
    
    /// 현재 진행률
    var progressValue: Double {
        Double(currentStarCount) / Double(totalStarCount)
    }
    
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            progressBar
            
            Spacer()
            
            progressInfo
        }
        .frame(maxWidth: 370, alignment: .leading)
    }
    
    private var progressBar: some View {
        VStack(alignment: .leading, spacing: 5) {
            // 남은 별 표시 텍스트
            Text(rewardText)
                .font(.mainTextSemiBold16)
                .foregroundStyle(.brown02)
            
            // 프로그레스 바
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .frame(height: 8)
                    .foregroundStyle(.gray07)
                
                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: 4)
                        .frame(
                            width: geo.size.width * progressValue,
                            height: 8
                        )
                        .foregroundStyle(.brown01)
                }
            }
            .frame(width: 255, height: 8)
        }
    }
    
    /// 프로그레스 정보
    private var progressInfo: some View {
        HStack(spacing: 5) {
            Text("\(currentStarCount)")
                .font(.mainTextSemiBold38)
                .foregroundStyle(.black03)
            
            Text("/")
                .font(.mainTextLight24)
                .foregroundStyle(.gray03)
            
            Text(convertStyleText("\(totalStarCount)★"))
                .font(.mainTextSemiBold24)
                .foregroundStyle(.brown02)
        }
    }
    
    /// 부분 텍스트 스타일 변환
    private func convertStyleText(_ text: String) -> AttributedString {
        var attributedString = AttributedString(text)
        
        if let starRange = attributedString.range(of: "★") {
            attributedString[starRange].foregroundColor = .brown02
            attributedString[starRange].font = .mainTextSemiBold24
        }
        
        return attributedString
    }
}

#Preview {
    RewardProgressView()
}
