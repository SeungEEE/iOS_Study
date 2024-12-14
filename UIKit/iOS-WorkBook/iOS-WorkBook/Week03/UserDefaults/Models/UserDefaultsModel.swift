//
//  UserDefaultsModel.swift
//  iOS-WorkBook
//
//  Created by 이승진 on 12/14/24.
//

import Foundation

class UserDefaultsModel {
    private let userDefaults = UserDefaults.standard
    private let userTextKey: String = "userText"
    
    /// 유저가 입력한 텍스트 값을 UserDefaults에 저장
    /// - Parameter Text : 유저가 입력한 텍스트 값
    public func saveUserText(_ Text: String) {
        userDefaults.set(Text, forKey: userTextKey)
    }
    
    /// UserDefaults에 저장된 값을 불러오기
    /// - Returns: 저장된 값 String으로 return
    public func loadUserText() -> String? {
        return userDefaults.string(forKey: userTextKey)
    }
}
