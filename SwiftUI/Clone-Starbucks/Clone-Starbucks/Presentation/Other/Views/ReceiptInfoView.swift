//
//  ReceiptInfoView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/15/25.
//

import SwiftUI

struct ReceiptInfoView: View {
    let receipt: ReceiptsModel
    
    @State private var showImage = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 9) {
                Text("\(receipt.store)")
                    .font(.mainTextSemiBold18)
                    .foregroundStyle(.black)
                Text("\(receipt.time)")
                    .font(.mainTextMedium16)
                    .foregroundStyle(.gray03)
                Text("\(receipt.totalAmount)원")
                    .font(.mainTextSemiBold18)
                    .foregroundStyle(.brown02)
                Divider()
            }
            
            Spacer()
            
            Button {
                showImage = true
            } label: {
                Image(.receipt)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .fullScreenCover(isPresented: $showImage) {
                if let uiImage = receipt.receiptImage?.toUIImage() {
                    ReceiptImageView(image: uiImage, isPresented: $showImage)
                }
            }
        }
    }
}

//#Preview {
//    ReceiptInfoView()
//}
