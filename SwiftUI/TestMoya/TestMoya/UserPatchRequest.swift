//
//  UserPatchRequest.swift
//  TestMoya
//
//  Created by 이승진 on 5/22/25.
//

import Foundation

struct UserPatchRequest: Codable {
    let name: String?
    let age: Int?
    let address: String?
    let height: Double?
}
