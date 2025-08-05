//
//  TemperatureToggleView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/3/25.
//

import SwiftUI

/// 온도 선택 토글 뷰
struct TemperatureToggleView: View {
    
    // MARK: - Property
    /// 현재 선택된 온도 (상위 뷰에서 바인딩)
    @Binding var selected: CoffeeTemperature
    
    /// 선택 가능한 온도 목록
    let available: [CoffeeTemperature]
    
    /// 선택 애니메이션을 위한 네임스페이스
    @Namespace private var animation
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: .zero) {
            // 온도 항목 별 버튼 생성
            ForEach(available, id: \.self) { temp in
                toggleButton(temp)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 999)
                .fill(.gray07)
        }
    }
    
    private func toggleButton(_ temp: CoffeeTemperature) -> some View {
        Button {
            withAnimation {
                selected = temp
            }
        } label: {
            Text(temp.rawValue)
                .font(.mainTextSemiBold18)
                .foregroundStyle(selected == temp ? selectedColor(for: temp) : .gray02)
                .frame(maxWidth: .infinity, minHeight: 36)
                .background {
                    ZStack {
                        if selected == temp {
                            Capsule()
                                .fill(.white)
                                .shadow01()
                                .matchedGeometryEffect(id: "underline", in: animation)
                        }
                    }
                }
        }
    }
    
    /// 선택된 온도에 따라 다른 강조 색상 제공
    private func selectedColor(for temp: CoffeeTemperature) -> Color {
        switch temp {
        case .hot:
            return .red
        case .iced:
            return .blue
        }
    }
}

#Preview {
    TemperatureToggleView(selected: .constant(.hot), available: [
        .hot, .iced
    ])
}
