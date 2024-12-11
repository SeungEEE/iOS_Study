//
//  LoginViewController.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/10/24.
//

import UIKit
import Then

class LoginViewController: UIViewController {
    
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
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }
    
    @objc
    private func kakaoLoginButtonTapped() {
        
    }

    @objc
    private func appleLoginButtonTapped() {
        
    }
}
