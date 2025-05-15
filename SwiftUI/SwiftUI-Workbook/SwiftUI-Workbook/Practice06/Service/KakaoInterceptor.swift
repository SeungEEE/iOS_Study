//
//  KakaoInterceptor.swift
//  SwiftUI-Workbook
//
//  Created by 이승진 on 5/15/25.
//

import Foundation
import Alamofire

class KakaoInterceptor: RequestInterceptor, @unchecked Sendable {
    private let kakaoAPIKey: String
    
    init(apiKey: String) {
        self.kakaoAPIKey = apiKey
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var request = urlRequest
        request.headers.add(.authorization("KakaoAK \(kakaoAPIKey)"))
        
        completion(.success(request))
    }
}
