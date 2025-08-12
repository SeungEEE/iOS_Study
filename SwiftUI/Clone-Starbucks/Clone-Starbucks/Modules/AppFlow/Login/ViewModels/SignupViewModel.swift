//
//  SignupViewModel.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/29/25.
//

import SwiftUI

class SignupViewModel: ObservableObject {
    @Published var signupModel: SignupModel = SignupModel(nickname: "", id: "", pwd: "")
    
    @AppStorage("nickname") private var nickname: String = ""
    @AppStorage("id") private var id: String = ""
    @AppStorage("pwd") private var pwd: String = ""
    
    func saveUserData() {
        nickname = signupModel.nickname
        id = signupModel.id
        pwd = signupModel.pwd
    }
}
