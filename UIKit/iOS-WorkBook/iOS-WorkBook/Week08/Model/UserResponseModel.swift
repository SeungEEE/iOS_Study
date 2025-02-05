//
//  UserResponseModel.swift
//  iOS-WorkBook
//
//  Created by 이승진 on 2/5/25.
//

import Foundation

struct UserResponseModel: Codable {
    let id: Int
    let email: String
    let password: String
    let name: String
    let role: String
    let avator: String
}
