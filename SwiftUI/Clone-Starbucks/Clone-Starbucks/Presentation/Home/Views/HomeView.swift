//
//  HomeView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/30/25.
//

import SwiftUI

struct HomeView: View {
    var viewModel: HomeViewModel = .init()
    @AppStorage("nickname") private var nickname: String?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                topBanner
                
                LazyVStack(alignment: .center, spacing: 20) {
                    Image(.banner01)
                        .resizable()
                        .scaledToFit()
                    
                    recommendMenuScrollView
                    
                    Image(.banner02)
                        .resizable()
                        .scaledToFit()
                        
                    Image(.banner03)
                        .resizable()
                        .scaledToFit()
                        
                    
                    adMenuScrollView
                    
                    Image(.banner04)
                        .resizable()
                        .scaledToFit()
                    
                    Image(.banner05)
                        .resizable()
                        .scaledToFit()
                    
                    Image(.banner06)
                        .resizable()
                        .scaledToFit()
                    
                    dessertMenuScrollView
                    
                    Image(.banner07)
                        .resizable()
                        .scaledToFit()
                    
                    Image(.banner08)
                        .resizable()
                        .scaledToFit()
                    
                    Image(.banner09)
                        .resizable()
                        .scaledToFit()
                    
                }
                .padding(.horizontal, 10)
            }
            .navigationDestination(for: Int.self) { coffeeId in
                CoffeeDetailView(coffee: viewModel.detail(for: coffeeId))
            }
        }
    }
    
    /// 상단 배너
    private var topBanner: some View {
        ZStack {
            Image(.topImg)
            VStack(alignment: .leading, spacing: 30) {
                Text("골든 미모사 그린 티와 함께\n행복한 새해의 축배를 들어요!")
                    .font(.mainTextBold24)
                
                StarProgressBar(currentStars: 9, maxStars: 12)
            }
            .padding(.horizontal, 36)
            .padding(.top, 150)
        }
    }
    
    /// 추천메뉴 스크롤뷰
    private var recommendMenuScrollView: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text(nickname ?? "(설정 닉네임)")
                .font(.mainTextBold24)
                .foregroundStyle(.brown01)
            + Text("님을 위한 추천 메뉴")
                .font(.mainTextBold24)
                .foregroundStyle(.black)
            
            CoffeeScrollView(coffeeCards: viewModel.coffeeCard)
        }
        .padding(.horizontal, 10)
    }
    
    /// 광고 메뉴 스크롤뷰
    private var adMenuScrollView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("What's New")
                .font(.mainTextBold24)
                .foregroundStyle(.black)
            
            AdScrollView(adCards: viewModel.adCard)
            
        }
        .padding(.horizontal, 10)
    }
    
    /// 디저트 메뉴 스크롤뷰
    private var dessertMenuScrollView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("하루가 달콤해지는 디저트")
                .font(.mainTextBold24)
                .foregroundStyle(.black)
            
            DessertScrollView(dessertCards: viewModel.dessertCard)
        }
        .padding(.horizontal, 10)
    }
}

//#Preview {
//    HomeView()
//}

struct HomeView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            HomeView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
