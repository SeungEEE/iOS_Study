//
//  UserInfoResponse.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/23/25.
//

import Foundation

struct UserInfoResponse: Codable {
    let id: Int
    let properties: [String: String]?
}
