//
//  TokenInfo.swift
//  TestKeychain
//
//  Created by 이승진 on 5/15/25.
//

import Foundation

struct TokenInfo: Codable {
    let accessToken: String
    let refreshToken: String
}
