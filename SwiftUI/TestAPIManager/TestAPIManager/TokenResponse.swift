//
//  TokenResponse.swift
//  TestAPIManager
//
//  Created by 이승진 on 5/22/25.
//

import Foundation

struct TokenResponse: Codable {
    var accessToken: String
    var refreshToken: String
}
