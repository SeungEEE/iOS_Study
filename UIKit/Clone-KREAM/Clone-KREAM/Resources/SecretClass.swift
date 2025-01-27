//
//  SecretClass.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/27/25.
//

import Foundation

class SecretClass {
    static var shared = SecretClass()
    
    func kakaoLoginAppKey() -> String {
        if let kakaoAppKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_KEY") as? String {
            return kakaoAppKey
        } else {
            return "Not Key"
        }
    }
    
    func baseURL() -> String {
        if let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String {
            return baseURL
        } else {
            return "BaseURL Not Found"
        }
    }
}
