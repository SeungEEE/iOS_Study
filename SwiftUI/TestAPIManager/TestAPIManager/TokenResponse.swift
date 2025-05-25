//
//  TokenResponse.swift
//  TestAPIManager
//
//  Created by 이승진 on 5/22/25.
//

import Foundation

struct TokenResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: UserInfo
}
