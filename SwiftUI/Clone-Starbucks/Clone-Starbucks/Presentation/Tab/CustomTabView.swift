//
//  CustomTabView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/30/25.
//

import SwiftUI

struct CustomTabView: View {
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Image(.homeIcon)
                        .renderingMode(.template)
                    Text("Home")
                }
            
            PayView()
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Pay")
                }
            
            OrderView()
                .tabItem {
                    Image(.orderIcon)
                        .renderingMode(.template)
                    Text("Order")
                }
            
            ShopView()
                .tabItem {
                    Image(.shopIcon)
                        .renderingMode(.template)
                    Text("Shop")
                }
            
            OtherView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("Other")
                }
        }
        .tint(.green02)
    }
}

#Preview {
    CustomTabView()
}
