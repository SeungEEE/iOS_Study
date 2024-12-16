//
//  LoginModel.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/10/24.
//

import Foundation

struct LoginModel {
    let id: String
    let pwd: String
    
    /// UserDefaults에 저장하는 메서드
    public func savedUserDefaults() {
        UserDefaults.standard.set(id, forKey: "userId")
        UserDefaults.standard.set(pwd, forKey: "userPwd")
    }
    
    /// UserDefaults에서 회원 아이디, 비밀번호 불러오기
    /// - Returns: 아이디, 비밀번호 반환
    static func loadUserDefaults() -> LoginModel? {
        guard let id = UserDefaults.standard.string(forKey: "userId"),
              let pwd = UserDefaults.standard.string(forKey: "userPwd")
        else { return nil }
        return LoginModel(id: id, pwd: pwd)
    }
}
