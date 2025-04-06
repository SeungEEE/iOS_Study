//
//  ColorNavigationView.swift
//  SwiftUI-Workbook
//
//  Created by 이승진 on 4/3/25.
//

import SwiftUI

struct ColorNavigationView: View {
    @Bindable var viewModel: RainbowViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 70) {
            if let selectedRainbowModel = viewModel.selectedRainbowModel {
                Text("현재 선택된 색상 \n\(selectedRainbowModel.returnColorName())")
                    .font(.title)
                    .foregroundStyle(.black)
                
                Button {
                    viewModel.appleLogoColor = selectedRainbowModel.returnColor()
                    dismiss()
                } label: {
                    Text("사과 색 바꾸기")
                        .padding(.vertical, 43)
                        .padding(.horizontal, 36)
                        .overlay {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(.clear)
                                .stroke(.black, style: .init(lineWidth: 1))
                        }
                }
            }
        }
        .navigationTitle("색 네비")
    }
}
