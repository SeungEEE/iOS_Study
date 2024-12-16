//
//  MyProfileEditView.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/13/24.
//

import UIKit
import Then
import SnapKit

class MyProfileEditView: UIView {
    // MARK: - UI Componets
    /// 프로필 이미지
    public var profileImageView = UIImageView().then {
        $0.image = UIImage(named: "profileImage")
        $0.contentMode = .scaleAspectFit
    }
    
    /// 프로필 정보 텍스트 라벨
    private let profileInfoLabel = UILabel().then {
        $0.text = "프로필 정보"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.textAlignment = .left
    }
    
    /// 유저 이메일 텍스트 라벨
    private let userEmailLabel = UILabel().then {
        $0.text = "유저 이메일"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textAlignment = .left
    }
    
    
    /// 유저 이메일 텍스트필드
    public lazy var userEmailTextField = UITextField().then {
        $0.applyCustomStyle(placeholder: "새로운 이메일을 입력해주세요",
                            defaultValueKey: "userId"
        )
    }
    
    /// 유저 이메일 변경 / 확인 버튼
    public lazy var userEmailChangeButton = UIButton().then {
        $0.setTitle("변경", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    /// 이메일 + 변경/확인 버튼 스택뷰
    private lazy var userEmailStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 9
    }
    
    /// 유저 비밀번호 텍스트 라벨
    private let userPwdLabel = UILabel().then {
        $0.text = "유저 비밀번호"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    /// 유저 비밀번호 텍스트필드
    public lazy var userPwdTextField = UITextField().then {
        $0.applyCustomStyle(
            placeholder: "새로운 비밀번호를 입력해주세요",
            defaultValueKey: "userPwd"
        )
    }
    
    /// 유저 비밀번호 변경 / 확인 버튼
    public lazy var userPwdChangeButton = UIButton().then {
        $0.setTitle("변경", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    /// 비밀번호 + 변경/확인 버튼 스택뷰
    private lazy var userPwdStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 9
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
//    private func makeTextField(defaultValueKey: String) -> UITextField {
//        let tf = UITextField()
//        let defaultValue = UserDefaults.st
//    }
    
    
    private func setup() {
        backgroundColor = .white
        /// StackView
        [userEmailTextField, userEmailChangeButton].forEach { userEmailStackView.addArrangedSubview($0) }
        [userPwdTextField, userPwdChangeButton].forEach { userPwdStackView.addArrangedSubview($0) }
        
        /// Components
        [profileImageView, profileInfoLabel, userEmailLabel, userEmailStackView, userPwdLabel, userPwdStackView].forEach {
            addSubview($0)
        }
    }
    
    private func setConstraints() {
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(90)
            $0.top.equalToSuperview().offset(144)
            $0.centerX.equalToSuperview()
        }
        
        profileInfoLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(27)
        }
        
        userEmailLabel.snp.makeConstraints {
            $0.top.equalTo(profileInfoLabel.snp.bottom).offset(23)
            $0.leading.trailing.equalToSuperview().inset(27)
        }
        
        userEmailTextField.snp.makeConstraints {
            $0.width.equalTo(282)
        }
        
        userEmailChangeButton.snp.makeConstraints {
            $0.width.equalTo(58)
        }
        
        userEmailStackView.snp.makeConstraints {
            $0.top.equalTo(userEmailLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(27)
            $0.height.equalTo(32)
        }
        
        userPwdLabel.snp.makeConstraints {
            $0.top.equalTo(userEmailStackView.snp.bottom).offset(23)
            $0.leading.trailing.equalToSuperview().inset(27)
        }
        
        userPwdTextField.snp.makeConstraints {
            $0.width.equalTo(282)
        }
        
        
        userPwdChangeButton.snp.makeConstraints {
            $0.width.equalTo(58)
        }
        
        userPwdStackView.snp.makeConstraints {
            $0.top.equalTo(userPwdLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(27)
            $0.height.equalTo(32)
        }
    }
}
