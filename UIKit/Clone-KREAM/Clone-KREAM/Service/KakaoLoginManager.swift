//
//  KakaoLoginManager.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/23/25.
//

import Foundation
import Alamofire
import KakaoSDKAuth
import KakaoSDKUser

@MainActor
class KakaoLoginManager {
    static let shared = KakaoLoginManager()
    
    func fetchAcessToken() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            if UserApi.isKakaoTalkLoginAvailable() {
                UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let oauthToken = oauthToken {
                        continuation.resume(returning: oauthToken.accessToken)
                    }
                }
            } else {
                UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let oauthToken = oauthToken {
                        continuation.resume(returning: oauthToken.accessToken)
                    }
                }
            }
        }
    }
    
    func fetchUserNickname(accessToken: String) async throws -> String {
        let url = "https://kapi.kakao.com/v2/user/me"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get, headers: headers).responseDecodable(of: UserInfoResponse.self) { response in
                switch response.result {
                case .success(let userInfo):
                    if let nickname = userInfo.properties?["nickname"] {
                        continuation.resume(returning: nickname)
                    } else  {
                        continuation.resume(throwing: KakaoLoginError.nickNameNotFound)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
}
