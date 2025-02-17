//
//  GestureViewController.swift
//  iOS-WorkBook
//
//  Created by 이승진 on 2/17/25.
//

import UIKit

class GestureViewController: UIViewController {
    
    private lazy var gestureView: GestureImageView = {
        let view = GestureImageView()
        view.loadImage(from: "https://blog.malcang.com/wp-content/uploads/2023/08/pexels-mohan-nannapaneni-14744551-scaled.jpeg")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = gestureView
    }
    
}
