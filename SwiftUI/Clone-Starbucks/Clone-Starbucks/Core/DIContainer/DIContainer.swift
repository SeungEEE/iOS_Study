//
//  DIContainer.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/3/25.
//

import Foundation

/// 앱 전역에서 사용할 의존성 주입 컨테이너 클래스
/// ViewModel, Router, UseCase 등 여러 공통 인스턴스를 중앙에서 주입하고 공유하기 위한 용도로 사용
class DIContainer: ObservableObject {
    
    /// 화면 전환 제어하는 네비게이션 라우터
    @Published var navigationRouter: NavigationRouter
    
    /// UseCase 및 API 호출을 담당하는 서비스 객체
    /// API 요청, 데이터 가공 등 비즈니스 로직을 처리하는 UseCase 계층 서비스
    @Published var useCaseService: UseCaseService
    
    /// 공유 데이터 관리를 위한 액터 서비스 객체
    @Published var actorService: ActorService
    
    /// DIContainer 초기화 함수
    /// 외부에서 navigationRouter와 useCaseService를 주입 받아 사용할 수 있도록 구성
    /// 기본 값으로는 각각 새로운 인스턴스를 생성하여 초기화
    init(
        navigationRouter: NavigationRouter = .init(),
        useCaseService: UseCaseService = .init(),
        actorService: ActorService = .init()
    ) {
        self.navigationRouter = navigationRouter
        self.useCaseService = useCaseService
        self.actorService = actorService
    }
}
