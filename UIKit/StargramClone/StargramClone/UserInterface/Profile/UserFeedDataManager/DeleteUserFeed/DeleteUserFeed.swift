//
//  DeleteUserFeed.swift
//  StargramClone
//
//  Created by 이승진 on 2023/10/27.
//

import Foundation

struct DeleteUserFeed: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: String?
}
