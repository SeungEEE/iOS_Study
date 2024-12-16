//
//  LoginViewController.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/10/24.
//

import UIKit
import Then

class LoginViewController: UIViewController {
    
    let loginModel: LoginModel = LoginModel(id: "SeungE", pwd: "1234")
    
    /// 로그인 뷰
    private lazy var loginView = LoginView().then {
        $0.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        $0.kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
        $0.appleLoginButton.addTarget(self, action: #selector(appleLoginButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = loginView
    }
    
    // MARK: - Action
    @objc
    private func loginButtonTapped() {
        guard let inputId = loginView.idTextField.text,
              let inputPwd = loginView.pwdTextField.text,
              !inputId.isEmpty, !inputPwd.isEmpty else {
            print("아이디와 비밀번호를 입력해주세요")
            return
        }
        
        if let storedLoginModel = LoginModel.loadUserDefaults() {
            if storedLoginModel.id == inputId && storedLoginModel.pwd == inputPwd {
                print("기존 사용자 로그인 성공")
                changeRootView()
            } else {
                print("아이디 또는 비밀번호 불일치")
            }
        } else {
            let newLogin = LoginModel(id: inputId, pwd: inputPwd)
            newLogin.savedUserDefaults()
            print("아이디 비밀번호 새롭게 갱신 및 로그인 성공")
            changeRootView()
        }
    }
    
    @objc
    private func kakaoLoginButtonTapped() {
        
    }
    
    @objc
    private func appleLoginButtonTapped() {
        
    }
    
    /// 로그인 뷰 -> TabBarController
    private func changeRootView() {
        let rootVC = TabBarController()
        if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = window.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = rootVC
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
