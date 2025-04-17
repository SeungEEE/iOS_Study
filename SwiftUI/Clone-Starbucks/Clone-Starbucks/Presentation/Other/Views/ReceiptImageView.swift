//
//  ReceiptImageView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/16/25.
//

import SwiftUI

struct ReceiptImageView: View {
    let image: UIImage
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            
                VStack {
                    Spacer()
                    
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 16)
                        
                        Button {
                            isPresented = false
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.gray06)
                                .frame(width: 18, height: 18)
                                .padding(.top, 18)
                                .padding(.trailing, 30)
                        }
                    }
                    
                    Spacer()
            }
        }
    }
}
