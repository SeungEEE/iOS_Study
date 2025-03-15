//
//  TicketView.swift
//  SwiftUI-Workbook
//
//  Created by 이승진 on 3/15/25.
//

import SwiftUI

struct TicketView: View {
    var body: some View {
        ZStack {
            Image(.background)
            VStack {
                Spacer().frame(height: 114)
                
                mainTopTitle
                
                Spacer().frame(height: 134)
                
                mainBottomTitle
            }
        }
        .padding()
    }
    
    private var mainTopTitle: some View {
        VStack {
            Group {
                Text("마이펫의 이중생활2")
                    .font(.PretendardBold30)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                Text("본인 + 동반 1인")
                    .font(.PretendardLight16)
                Text("30,100원")
                    .font(.PretendardBold24)
            }
            .foregroundStyle(.white)
        }
        .frame(height: 84)
    }
    
    private var mainBottomTitle: some View {
        Button(action: {
            print("예매 버튼입니다.")
        }, label: {
            VStack {
                Image(systemName: "chevron.up")
                Text("예매하기")
                    .font(.PretendardSemiBold18)
            }
            .foregroundStyle(.white)
            .frame(width: 63 ,height: 40)
        })
    }
}

#Preview {
    TicketView()
}
