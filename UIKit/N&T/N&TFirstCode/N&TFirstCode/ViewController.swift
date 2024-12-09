//
//  ViewController.swift
//  N&TFirstCode
//
//  Created by 이승진 on 2023/12/26.
//

import UIKit

// FirstViewController
class ViewController: UIViewController {
    
    // 로그인 여부에 관련된 참/거짓 저장하는 속성
    var isLoggedIn = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        
        // 로그인이 되어있지 않다면 로그인화면 띄우기
        if !isLoggedIn {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
    }
    
    func makeUI() {
        view.backgroundColor = .gray
        
        // (네비게이션바 설정 관련) iOS버전 업데이트 되면서 바뀐 설정
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명으로
//        appearance.backgroundColor = .brown // 색상설정
        
//        appearance.configureWithTransparentBackground() // 투명으로
        
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        title = "Main"
    }
}
