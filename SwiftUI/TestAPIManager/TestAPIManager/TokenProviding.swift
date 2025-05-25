//
//  TokenProviding.swift
//  TestAPIManager
//
//  Created by 이승진 on 5/22/25.
//

import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}
