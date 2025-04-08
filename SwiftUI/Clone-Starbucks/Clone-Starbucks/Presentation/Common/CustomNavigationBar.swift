//
//  CustomNavigationBar.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/6/25.
//

import SwiftUI

struct CustomNavigationBar: View {
    let title: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            Text(title)
                .font(.mainTextMedium16)
                .foregroundColor(.black)
            
            Spacer()
            
            /// 대칭을 맞추려는 이미지
            Image(systemName: "chevron.left")
                .font(.title2)
                .opacity(0)
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}

#Preview {
    CustomNavigationBar(title: "가입하기")
}
