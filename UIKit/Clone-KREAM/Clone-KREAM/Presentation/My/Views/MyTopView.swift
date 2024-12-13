//
//  MyTopView.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/13/24.
//

import UIKit
import Then
import SnapKit

class MyTopView: UIView {
    
    // MARK: - UI Components
    /// 상단 설정 아이콘
    public lazy var settingButton = UIButton().then {
        $0.setImage(UIImage(named: "settingIcon"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    /// 상단 카메라 아이콘
    public lazy var cameraButton = UIButton().then {
        $0.setImage(UIImage(named: "cameraIcon"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    /// 프로필 이미지
    public var profileImageView = UIImageView().then {
        $0.image = UIImage(named: "profileImage")
        $0.contentMode = .scaleAspectFill
    }
    
    /// 닉네임 라벨
    public var nickNameLabel = UILabel().then {
        $0.text = "NickName"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    /// 팔로워 텍스트 라벨
    private let followerTextLabel = UILabel().then {
        $0.text = "팔로워"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    /// 팔로워 라벨
    public lazy var followerLabel = UILabel().then {
        $0.text = "300"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
    }
    
    /// 팔로워 스택뷰
    private lazy var followerStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 2
    }
    
    /// 팔로잉 텍스트 라벨
    private let followingTextLabel = UILabel().then {
        $0.text = "팔로잉"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    /// 팔로잉 라벨
    public lazy var followingLabel = UILabel().then {
        $0.text = "300"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
    }
    
    /// 팔로잉 스택뷰
    private lazy var followingStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 2
    }
    
    /// 팔로잉, 팔로워 스택뷰
    private lazy var followStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.spacing = 8
    }
    
    /// 닉네임, 팔로워, 팔로잉 스택뷰
    private lazy var infoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.alignment = .leading
        $0.spacing = 6
    }
    
    /// 프로필 수정 버튼
    public lazy var profileEditButton = UIButton().then {
        $0.setTitle("프로필 관리", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 9, weight: .regular)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1).cgColor
    }
    
    /// 프로필 공유 버튼
    public lazy var profileShareButton = UIButton().then {
        $0.setTitle("프로필 공유", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 9, weight: .regular)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1).cgColor
    }
    
    /// 프로필 버튼 스택뷰
    private lazy var profileButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 14
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
    private func setup() {
        [followerTextLabel, followerLabel].forEach { followerStackView.addArrangedSubview($0) }
        [followingTextLabel, followingLabel].forEach { followingStackView.addArrangedSubview($0) }
        [followerStackView, followingStackView].forEach { followStackView.addArrangedSubview($0) }
        [nickNameLabel, followStackView].forEach { infoStackView.addArrangedSubview($0) }
        [profileEditButton, profileShareButton].forEach { profileButtonStackView.addArrangedSubview($0) }
        
        [settingButton, cameraButton, profileImageView, infoStackView, profileButtonStackView].forEach {
            addSubview($0)
        }
    }
    
    private func setConstraints() {
        settingButton.snp.makeConstraints {
            $0.width.height.equalTo(25)
            $0.top.equalToSuperview().offset(75)
            $0.leading.equalToSuperview().offset(32.5)
        }
        
        cameraButton.snp.makeConstraints {
            $0.width.height.equalTo(25)
            $0.top.equalToSuperview().offset(75)
            $0.trailing.equalToSuperview().offset(-32.5)
        }
        
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(90)
            $0.top.equalTo(settingButton.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(32.5)
        }
        
        infoStackView.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
        
        profileEditButton.snp.makeConstraints {
            $0.height.equalTo(26)
        }
        
        profileShareButton.snp.makeConstraints {
            $0.height.equalTo(26)
        }
        
        profileButtonStackView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview().inset(32.5)
        }
    }
}
