//
//  CustomTabView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/30/25.
//

import SwiftUI

struct CustomTabView: View {
    @State var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(value: 0, content: {
                HomeView()
            }, label: {
                VStack {
                    Image(.homeIcon)
                        .renderingMode(.template)
                    Text("Home")
                }
            })
            
            Tab(value: 1, content: {
                PayView()
            }, label: {
                VStack {
                    Image(systemName: "creditcard")
                    Text("Pay")
                }
            })
            
            Tab(value: 2, content: {
                OrderView()
            }, label: {
                VStack {
                    Image(.orderIcon)
                        .renderingMode(.template)
                    Text("Order")
                }
            })
            
            Tab(value: 3, content: {
                ShopView()
            }, label: {
                VStack {
                    Image(.shopIcon)
                        .renderingMode(.template)
                    Text("Shop")
                }
                
            })
            
            Tab(value: 4, content: {
                OtherView()
            }, label: {
                VStack {
                    Image(systemName: "ellipsis")
                    Text("Other")
                }
                
            })
        }
        .tint(.green02)
    }
}

#Preview {
    CustomTabView()
}
