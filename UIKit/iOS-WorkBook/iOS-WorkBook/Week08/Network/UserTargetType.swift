//
//  UserTargetType.swift
//  iOS-WorkBook
//
//  Created by 이승진 on 2/5/25.
//

import Foundation
import Moya

enum UserTargetType {
    case getAllUsers
}

extension UserTargetType: TargetType {
    var baseURL: URL {
        guard let baseURL = URL(string: "https://api.escuelajs.co") else {
            fatalError("Error: Invalid URL")
        }
        
        return baseURL
    }
    
    var path: String {
        switch self {
        case .getAllUsers:
            return "/api/v1/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllUsers:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getAllUsers:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
}
