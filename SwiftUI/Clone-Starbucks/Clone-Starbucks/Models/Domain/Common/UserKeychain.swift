//
//  UserKeychain.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 9/22/25.
//

import Foundation

/// 유저 키체인 정보 모델
struct UserKeychain: Codable {
  var userName: String
  var userId: String
  var userPassword: String
  var kakaoAccessToken: String?
}
