//
//  CustomTabView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/30/25.
//

import SwiftUI

/// 커스텀 탭 뷰
struct CustomTabView: View {
    
    // MARK: - Property
    
    /// 현재 선택된 탭 상태
    @State var tabCase: TabCase = .home
    
    /// 의존성 주입 DI Container
    @EnvironmentObject var container: DIContainer
    
    /// 앱 광고 첫 진입시만 등장
    @AppStorage("hasAd") private var hasShowAd: Bool = false
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack(path: $container.navigationRouter.destination, root: {
            TabView(selection: $tabCase) {
                ForEach(TabCase.allCases, id: \.rawValue) { tab in
                    Tab(value: tab, content: {
                        tabView(tab: tab)
                            .tag(tab)
                    }, label: {
                        tabLabel(tab)
                    })
                }
            }
            .tint(.green02)
            .navigationDestination(for: NavigationDestination.self) { destination in
                NavigationRoutingView(destination: destination)
                    .environmentObject(container)
            }
            .task {
                hasShowAd = false
            }
        })
    }
    
    /// 아이콘 + 텍스트
    private func tabLabel(_ tab: TabCase) -> some View {
        VStack(spacing: 10) {
            tab.icon
                .renderingMode(.template)
            
            Text(tab.rawValue)
                .font(.mainTextRegular12)
                .foregroundStyle(.black01)
        }
    }
    
    /// 각 탭에 해당하는 탭뷰
    @ViewBuilder
    private func tabView(tab: TabCase) -> some View {
        Group {
            switch tab {
            case .home:
                HomeView(container: container)
            case .pay:
                PayView()
            case .order:
                OrderView()
            case .shop:
                ShopView()
            case .other:
                OtherView()
            }
        }
    }
}

struct CustomTabView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            CustomTabView()
                .environmentObject(DIContainer())
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
