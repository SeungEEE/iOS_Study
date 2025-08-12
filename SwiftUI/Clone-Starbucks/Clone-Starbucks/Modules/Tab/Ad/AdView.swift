//
//  AdView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/29/25.
//

import SwiftUI

struct AdView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 106) {
            Image(.ad)
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            buttonGroup
                .padding(.bottom, 38)
        }
        .safeAreaPadding(EdgeInsets(top: 0, leading: 0, bottom: 38, trailing: 0))
    }
    
    private var buttonGroup: some View {
        VStack(alignment: .trailing, spacing: 19) {
            Button {
                print("자세히 보기")
            } label: {
                Text("자세히 보기")
                    .frame(maxWidth: .infinity)
                    .font(.mainTextMedium18)
                    .foregroundStyle(Color.white)
                    .padding(.top, 19)
                    .padding(.bottom, 19)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.green01)
                    }
            }
            .padding(.leading, 18)
            .padding(.trailing, 18)
            
            Button {
                dismiss()
            } label: {
                Text("X 닫기")
                    .font(.mainTextLight14)
                    .foregroundStyle(.gray05)
            }
            .padding(.trailing, 37)
        }
    }
}

struct adView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            AdView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
