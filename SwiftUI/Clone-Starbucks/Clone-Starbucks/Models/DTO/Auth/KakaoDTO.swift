//
//  KakaoDTO.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 9/23/25.
//

import Foundation

/// 카카오 로그인 후 공통으로 사용될 사용자 데이터 전달용 프로토콜
protocol KakaoDTO {
  
  /// 카카오에서 발급된 사용자 인증 토큰
  var accessToken: String { get }
  
  /// 사용자 닉네임
  var nickname: String { get }
}

/// 카카오 로그인 후 획득한 사용자 정보 담는 구조체
struct KakaoUser: KakaoDTO {
  
  /// 카카오 인증 토큰
  var accessToken: String
  
  /// 사용자 닉네임
  var nickname: String
}
