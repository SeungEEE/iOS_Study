//
//  ViewController.swift
//  LoginProject
//
//  Created by 이승진 on 2023/09/19.
//

import UIKit

final class ViewController: UIViewController { // 클래스메서드는 구조체보다 느리게 동작. 동적 디스패치때문에 final 붙이면 더이상 상속 못하게 막음 -> 다이랙트 디스패치 일어나게함 (final 키워드)

//    let emailTextFieldView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.darkGray // 색
//        // 모서리 둥글게 만들기
//        view.layer.cornerRadius = 10
//        view.layer.masksToBounds = true
//        return view
//    }() // 클로저의 실행문 형태로 속성 만들기
    

    private let loginView = LoginView()
    
    // viewDidLoad보다 먼저 호출됨 - 뷰를 교체해줄 수 있음
    override func loadView() {
        // super.loadView() 필요없음
        view = loginView // 기본 뷰가 있지만 loginView로 할당
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print()
        setupAddTarget()
    }
    
    func setupAddTarget() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.passwordResetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    // 로그인 버튼 누르면 동작하는 함수
    @objc func loginButtonTapped() {
        // 서버랑 통신해서, 다음 화면으로 넘어가는 내용 구현
        print("다음 화면으로 넘어가기")
    }
    
    // 리셋버튼이 눌리면 동작하는 함수
    @objc func resetButtonTapped() {
        //만들기
        let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인버튼이 눌렸습니다.")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("취소버튼이 눌렸습니다.")
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        
        // 실제 띄우기
        self.present(alert, animated: true, completion: nil)
    }
}


