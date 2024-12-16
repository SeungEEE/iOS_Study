//
//  MyProfileEditViewController.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/13/24.
//

import UIKit
import Then

class MyProfileEditViewController: UIViewController {
    
    private lazy var myProfileEditView = MyProfileEditView().then {
        $0.userEmailChangeButton.addTarget(self, action: #selector(changeButtonTapped(_:)), for: .touchUpInside)
        $0.userPwdChangeButton.addTarget(self, action: #selector(changeButtonTapped(_:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = myProfileEditView
        setNavigationBar()
    }
    
    // MARK: - Function
    private func setNavigationBar() {
        navigationItem.title = "프로필 관리"
        
        let backBtn = UIBarButtonItem(image: UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.black), style: .plain, target: self, action: #selector(didTap))
        navigationItem.leftBarButtonItem = backBtn
    }
    
    // MARK: - Action
    @objc
    func didTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func changeButtonTapped(_ sender: UIButton) {
        let config = getButtonconfig(button: sender)
        guard let textField = config.textField,
              let userDefaultsKey = config.UserDefaultsKey
        else { return }
        
        if sender.titleLabel?.text == "변경" {
            sender.setTitle("확인", for: .normal)
            textField.isUserInteractionEnabled = true
            textField.becomeFirstResponder()
        } else if sender.titleLabel?.text == "확인" {
            if let text = textField.text, !text.isEmpty {
                savedUserDefaults(value: text, key: userDefaultsKey)
                textField.isUserInteractionEnabled = false
                textField.resignFirstResponder()
            }
        }
    }
    
    /// 변경 버튼이 아이디에 해당하는지 비밀번호에 해당하는지 판단하는 함수
    /// - Parameter button: 현재 눌린 UIButton
    /// - Returns: 눌린 버튼에 해당하는 아이디 또는 비밀번호 텍스트 필드 + UserDefaults 값
    private func getButtonconfig(button: UIButton) -> (textField: UITextField?, UserDefaultsKey: String?) {
        if button == myProfileEditView.userEmailChangeButton {
            return (myProfileEditView.userEmailTextField, "userId")
        } else if button == myProfileEditView.userPwdChangeButton {
            return (myProfileEditView.userPwdTextField, "userPwd")
        }
        return (nil, nil)
    }
    
    /// 변경된 값 UserDefaults에 저장
    /// - Parameters:
    /// - value: 새롭게 입력된 값
    /// - key: UserDefaults 키
    private func savedUserDefaults(value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
}
