//
//  RainbowViewController.swift
//  iOS-WorkBook
//
//  Created by 이승진 on 12/28/24.
//

import UIKit

class RainbowViewController: UIViewController {
    
    override func viewDidLoad() {
        view = RainbowView(frame: self.view.bounds)
    }
    
}
