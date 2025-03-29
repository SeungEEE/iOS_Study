//
//  LoginViewModel.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/17/25.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var pwd: String = ""
}
