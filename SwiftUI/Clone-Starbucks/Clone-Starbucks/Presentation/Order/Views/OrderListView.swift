//
//  OrderListView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/29/25.
//

import SwiftUI

struct OrderListView: View {
    var orderModel: OrderModel
    
    var body: some View {
        HStack(spacing: 16) {
            Image(uiImage: orderModel.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(orderModel.name)
                    .font(.pretend(type: .semiBold, size: 16))
                    .foregroundStyle(.gray06)
                Text(orderModel.nameEnglish)
                    .font(.pretend(type: .semiBold, size: 13))
                    .foregroundStyle(.gray03)
            }
//            Spacer()
        }
    }
}

#Preview {
    OrderListView(orderModel: .init(name: "추천", nameEnglish: "Recommend", image: .order1))
}
