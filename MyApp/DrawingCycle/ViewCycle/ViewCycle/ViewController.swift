//
//  ViewController.swift
//  ViewCycle
//
//  Created by 이승진 on 2023/12/17.
//

import UIKit

final class ViewController: UIViewController {
    
    // 제약 조건을 저장하기 위한 변수 선언
    // (나중에 접근해서 변경하기 위함)
    private var btnHeightAnchor: NSLayoutConstraint!
    private var btnWidthAnchor: NSLayoutConstraint!
    
    // 버튼
    private lazy var myButton: MyButton = {
        let button = MyButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = .yellow
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleAnimationEffect), for: .touchUpInside)
        button.onAndOff = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpConstraints()
    }
    
    func setUp() {
        view.addSubview(myButton)
    }
    
    func setUpConstraints() {
        myButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 원칙적인 오토레이아웃 설정 (높이, 넓이)
//        myButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        myButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // 제약조건을 변수에 저장
        btnHeightAnchor = myButton.heightAnchor.constraint(equalToConstant: 60)
        btnWidthAnchor = myButton.widthAnchor.constraint(equalToConstant: 100)
        
        btnHeightAnchor.isActive = true
        btnWidthAnchor.isActive = true
        
        // 원칙적인 오토레이아웃 설정 (가운데 정렬 - X, Y축)
        myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func handleAnimationEffect() {
        print(#function)
        
        // 높이/넓이 변경 관한 애니메이션 코드
        if !myButton.onAndOff {
            btnHeightAnchor.constant = 400
            btnWidthAnchor.constant = 200
        } else {
            btnHeightAnchor.constant = 60
            btnWidthAnchor.constant = 100
        }
        
        UIView.animate(withDuration: 2) {
            self.view.layoutIfNeeded() // 당장 위치/크기 조정 함수(layoutSubviews 자동호출)
        } completion: { success in
            print("애니메이션 처리 완료")
        }
        
        myButton.toggle()
    }
}
