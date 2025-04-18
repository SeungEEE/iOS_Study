//
//  ReusableButton.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/30/25.
//

import SwiftUI

struct ReusableButton: View {
    let image: UIImage
    let name: String
    //    let action: () -> Void
    
    var body: some View {
        //        Button(action: action) {
        VStack(spacing: 4) {
            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.green00)
            }
            .frame(maxWidth: 48, maxHeight: 48)
            
            Text(name)
                .font(.mainTextSemiBold16)
                .foregroundStyle(.black01)
        }
        .padding(.vertical, 19)
        .frame(width: 102, height: 108)
        .background(.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 2.5, x: 0, y: 0)
        //        }
    }
}

#Preview {
    ReusableButton(image: .starIcon, name: "별 히스토리") 
}
