//
//  MyProfileEditViewController.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/13/24.
//

import UIKit

class MyProfileEditViewController: UIViewController {
    
    private lazy var myProfileEditView = MyProfileEditView()
    
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
}
