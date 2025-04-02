//
//  OtherHeaderView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/30/25.
//

import SwiftUI

struct OtherHeaderView: View {
    var body: some View {
            HStack {
                Text("Other")
                    .font(.mainTextBold24)
                
                Spacer()
                
                Button {
                    print("로그아웃 버튼입니다")
                } label: {
                    Image(.logoutBtn)
                        .frame(width: 35, height: 35)
                }
            }
            .padding(.horizontal, 23.5)
            .foregroundStyle(.black)
        }
}

#Preview {
    OtherHeaderView()
}
