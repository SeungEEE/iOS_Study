//
//  CoffeeStateToggleButton.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/7/25.
//

import SwiftUI

struct CoffeeStateToggleButton: View {
    let currentState: DetailCoffee.CoffeeState

    var body: some View {
        
        HStack(spacing: 0) {
            ForEach([DetailCoffee.CoffeeState.hot, DetailCoffee.CoffeeState.iced], id: \.self) { state in
                Text(state.rawValue)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(color(for: state))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        Group {
                            if currentState == state {
                                Color.white
                                    .clipShape(Capsule())
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                            } else {
                                Color.clear
                            }
                        }
                    )
            }
        }
        .background(Color.gray.opacity(0.2))
        .clipShape(Capsule())
        .padding(.horizontal)
    }
    
    /// 세가지 색을 사용하기 위한 함수 (선택 했을 시 / 안했을 시 + 선택했을 때 아이스 or 핫)
    private func color(for state: DetailCoffee.CoffeeState) -> Color {
        if currentState == state {
            return state == .hot ? .red : .blue
        } else {
            return .gray
        }
    }
}


//#Preview {
//    CoffeeStateToggleButton(selected: )
//}
