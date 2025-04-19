//
//  DetailNavigationBar.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/7/25.
//

import SwiftUI

struct DetailNavigationBar: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Capsule()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.black)
                    )
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Capsule()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.black)
                    )
            }
        }
        .padding(.top, 20) // safeArea 대응
    }
}

#Preview {
    DetailNavigationBar()
}
