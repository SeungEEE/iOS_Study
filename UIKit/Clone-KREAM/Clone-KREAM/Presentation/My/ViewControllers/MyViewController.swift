//
//  MyViewController.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/11/24.
//

import UIKit
import Then

class MyViewController: UIViewController {

    private lazy var myView = MyView().then {
        $0.myTopView.profileEditButton.addTarget(self, action: #selector(profileEditButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = myView
    }
    
    // MARK: - Action
    @objc
    private func profileEditButtonTapped() {
        let profileEditVC = MyProfileEditViewController()
        navigationController?.pushViewController(profileEditVC, animated: true)
    }
}
