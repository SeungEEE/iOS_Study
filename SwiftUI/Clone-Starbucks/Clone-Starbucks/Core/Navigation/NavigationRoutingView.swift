//
//  NavigationRoutingView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/3/25.
//

import SwiftUI

/// 앱 내에서 특정 화면으로의 이동을 처리하는 라우팅 뷰
/// NavigationDestination enum 값 기준으로 적절한 화면 렌더링
struct NavigationRoutingView: View {
    
    /// DI Container: 의존성 주입 위한 환경 객체
    @EnvironmentObject var container: DIContainer
    
    /// 현재 이동할 화면을 나타내는 상태값
    @State var destination: NavigationDestination
    
    // MARK: - Body
    var body: some View {
        Group {
            switch destination {
            case .signup:
                // 회원 가입 화면
                SignupView()
            case .coffeeDetail(let id):
                // 커피 상세 화면
                CoffeeDetailView(coffeeId: id)
            case .receiptView:
                // 영수증 리스트 화면
                ReceiptView()
            case .findStoreView:
                // 매장 찾기 화면
                OrderView()
            }
        }
        // 각 하위 뷰에 DI Cotainer 공유
        .environmentObject(container)
    }
}
