//
//  UseCaseService.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/4/25.
//

import Foundation

class UseCaseService {
    let kakaoManager: KakaoLoginManager
  init(kakaoManager: KakaoLoginManager) {
    self.kakaoManager = kakaoManager
  }
}
