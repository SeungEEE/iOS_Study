//
//  LoginView.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/10/24.
//

import UIKit
import Then
import SnapKit

class LoginView: UIView {
    
    // MARK: - UI Componets
    /// 로고
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo")
        $0.contentMode = .scaleAspectFit
    }
    
    /// 이메일 타이틀 라벨
    private let idTitleLabel = UILabel().then {
        $0.text = "이메일 주소"
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    /// 이메일 입력 텍스트필드
    public lazy var idTextField = UITextField().then {
        $0.applyCustomStyle(
            placeholder: "예) kream@kream.co.kr",
            placeholderColor: .lightGray,
            fontSize: 12,
            borderColor: .lightGray,
            cornerRadius: 15,
            padding: 16,
            keyboardType: .emailAddress
        )
    }
    
    /// 이메일 스택뷰
    private lazy var idStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .equalSpacing
    }
    
    /// 비밀번호 타이틀 라벨
    private let pwdTitleLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    /// 비밀번호 입력 텍스트필드
    public lazy var pwdTextField = UITextField().then {
        $0.applyCustomStyle(
            placeholder: "비밀번호를 입력해주세요",
            placeholderColor: .lightGray,
            fontSize: 12,
            borderColor: .lightGray,
            cornerRadius: 15,
            padding: 16,
            keyboardType: .default
        )
    }
    
    /// 이메일 스택뷰
    private lazy var pwdStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .equalSpacing
    }
    
    /// 로그인 버튼
    public lazy var loginButton = LoginButton(type: .normal)
    
    private lazy var centerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 17
        $0.distribution = .equalSpacing
    }
    
    /// 카카오 로그인 버튼
    public lazy var kakaoLoginButton = LoginButton(type: .social(image: "kakaoIcon", title: "카카오로 로그인"))
    
    /// apple 로그인 버튼
    public lazy var appleLoginButton = LoginButton(type: .social(image: "appleIcon", title: "Apple로 로그인"))
    
    /// 소셜 로그인 버튼 스택뷰
    private lazy var loginStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 22
        $0.distribution = .equalSpacing
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        
        /// 스택뷰
        [idTitleLabel, idTextField].forEach { idStackView.addArrangedSubview($0) }
        [pwdTitleLabel, pwdTextField].forEach { pwdStackView.addArrangedSubview($0) }
        [idStackView, pwdStackView, loginButton].forEach { centerStackView.addArrangedSubview($0) }
        [kakaoLoginButton, appleLoginButton].forEach { loginStackView.addArrangedSubview($0) }
        
        /// 뷰
        [logoImageView, centerStackView, loginStackView].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(126)
            $0.leading.trailing.equalToSuperview().inset(53)
            $0.height.equalTo(75)
        }
        
        loginButton.snp.makeConstraints {
            $0.height.equalTo(38)
        }
        
        idTextField.snp.makeConstraints {
            $0.height.equalTo(34)
        }
        
        pwdTextField.snp.makeConstraints {
            $0.height.equalTo(34)
        }
        
        centerStackView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(87)
            $0.leading.trailing.equalToSuperview().inset(45)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.height.equalTo(38)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.height.equalTo(38)
        }
        
        loginStackView.snp.makeConstraints {
            $0.top.equalTo(centerStackView.snp.bottom).offset(87)
            $0.leading.trailing.equalToSuperview().inset(47.5)
        }
    }
}
