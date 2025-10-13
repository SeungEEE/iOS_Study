//
//  LoginViewModel.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/17/25.
//

import SwiftUI

/// 로그인 화면에서 사용되는 뷰모델
@Observable
class LoginViewModel: ObservableObject {
  
  // MARK: - Property
  /// 키체인에 저장할 때 사용하는 고유 식별자 값
  let keychainValue: String = "Clone_StarbucksApp"
  
  /// 사용자 입력 ID
  var id: String = ""
  
  /// 사요앚 입력 비밀번호
  var password: String = ""
  
  /// 의존성 주입 컨테이너
  var container: DIContainer
  
  /// 앱 흐름 상태 관리하는 뷰모델
  private var appFlowViewModel: AppFlowViewModel
  
  /// 키체인 접근 위한 매니저 객체
  var keychainManager: KeychainManager = .standard
  
  // MARK: - Init
  /// 뷰모델 초기화
  init(container: DIContainer, appFlowViewModel: AppFlowViewModel) {
    self.container = container
    self.appFlowViewModel = appFlowViewModel
  }
  
  // MARK: - Public Function
  /// 앱 자체 로그인 처리 함수
  public func loginButtonTapped() async {
    guard let savedSession = keychainManager.loadSession(for: keychainValue) else {
      print("키체인에 저장된 세션 없음")
      return
    }
    
    if savedSession.userId == id && savedSession.userPassword == password {
      await self.changeView()
      print("로그인 성공")
    } else {
      print("로그인 실패")
    }
  }
  
  /// 카카오 로그인 처리 함수
  @MainActor
  public func kakaoLogin() async {
    do {
      let user = try await container.useCaseService.kakaoManager.login()
      await self.lo
    }
  }
  
  // MARK: - Private Function
  /// 로그인 성공 시 앱의 메인 탭 화면으로 전환
  private func changeView() async {
    await appFlowViewModel.changeAppState(.tab)
  }
  
  private func loadAndSaveKeychain(_ kakaoUser: KakaoUser) async {
    
  }
}
