//
//  SearchRouter.swift
//  Clone-KREAM
//
//  Created by 이승진 on 2/10/25.
//

import Foundation
import Moya

enum SearchRouter {
    case search(query: String)
}

extension SearchRouter: BaseURLProtocol {
    var path: String {
        switch self {
        case .search:
            return "/products/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .search(let query):
            return .requestParameters(parameters: ["q" : query], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let headers = ["Content-Tyep" : "application/json"]
        
        return headers
    }
}
