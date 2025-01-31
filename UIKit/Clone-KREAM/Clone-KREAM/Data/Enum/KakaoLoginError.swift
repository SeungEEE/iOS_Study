//
//  KakaoLoginError.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/22/25.
//

import Foundation

enum KakaoLoginError: Error, LocalizedError {
    case loginFailed
    case nickNameNotFound
    
    var errorDescription: String? {
        switch self {
        case .loginFailed:
            return "카카오 로그인 실패"
        case .nickNameNotFound:
            return "사용자 닉네임 찾을 수 없음"
        }
    }
}
