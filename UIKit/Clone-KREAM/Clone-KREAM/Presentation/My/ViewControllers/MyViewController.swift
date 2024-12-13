//
//  MyViewController.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/11/24.
//

import UIKit

class MyViewController: UIViewController {

    private lazy var myView = MyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = myView
    }
}
