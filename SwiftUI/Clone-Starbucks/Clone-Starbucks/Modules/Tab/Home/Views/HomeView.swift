//
//  HomeView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/30/25.
//

import SwiftUI

struct HomeView: View {
    
    
    // MARK: - Property
    
    @State var viewModel: HomeViewModel
    @AppStorage("hasAd") private var hasShowAd: Bool = false
    
    
    // MARK: - init
    
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }
    
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 20) {
                topContents
                centerContents
            }
        }
        .ignoresSafeArea()
        .contentMargins(.bottom, UIConstants.defaultScrollBottomPadding)
        .background(.white)
        .task {
            if !hasShowAd {
                viewModel.showAd = true
                hasShowAd = true
            }
        }
        .fullScreenCover(isPresented: $viewModel.showAd) {
            AdView()
        }
    }
    
    
    // MARK: - TopContents
    
    /// 상단 컨텐츠
    private var topContents: some View {
        ZStack(alignment: .bottom) {
            topImage
            imageAboveContents
        }
    }
    
    /// 상단 이미지
    private var topImage: some View {
        Image(.topImg)
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: 259)
            .ignoresSafeArea()
    }
    
    /// 이미지 위에 올라가는 컨텐츠
    private var imageAboveContents: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text("골든 미모사 그린 티와 함께 \n행복한 새해의 축배를 들어요!")
                .font(.mainTextBold24)
                .foregroundStyle(.black03)
                .lineLimit(nil)
                .lineSpacing(3.6)
            
            Spacer()
            
            seeMoreButton
            
            RewardProgressView()
        }
        .frame(height: 140)
        .offset(y: 33)
        .safeAreaPadding(.leading, 28)
        .safeAreaPadding(.trailing, 23)
    }
    
    /// 내용 보기 버튼
    private var seeMoreButton: some View {
        HStack(spacing: 4) {
            Text("내용 보기")
                .font(.mainTextRegular13)
                .foregroundStyle(.gray06)
            
            Image(.moreButton)
        }
    }
    
    
    // MARK: - CenterContents
    
    /// 중간 컨텐츠
    @ViewBuilder
    private var centerContents: some View {
        Group {
            ForEach(viewModel.mergedContents) { item in
                switch item {
                case .banner(let banner):
                    BannerView(image: banner.image)
                case .section(let section):
                    renderSection(section)
                }
            }
        }
        .offset(y: 33)
        .safeAreaPadding(.horizontal, 10)
    }
    
    /// 섹션별 렌더링
    @ViewBuilder
    private func renderSection(_ section: HomeSection) -> some View {
        switch section.contentType {
        case .coffee:
            if let coffees = section.items as? [CoffeeSummaryItem] {
                HomeMenuView(title: section.title, items: coffees) { summary in
                    guard CoffeeDataSource.detailItems.contains(where: { $0.id == summary.id }) else {
                        print("상세 커피 정보 없음: \(summary.name)")
                        return
                    }
                    
                    viewModel.container.navigationRouter.push(to: .coffeeDetail(id: summary.id))
                }
            }
            
        case .newRelease:
            if let newReleases = section.items as? [NewReleaseItem] {
                NewReleaseView(title: section.title, items: newReleases)
            }
            
        case .dessert:
            if let desserts = section.items as? [DessertMenuItem] {
                HomeMenuView(title: section.title, items: desserts) { _ in }
            }
        }
    }
}


struct HomeView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            HomeView(container: DIContainer())
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
