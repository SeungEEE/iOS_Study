//
//  ThirdViewController.swift
//  NextVC
//
//  Created by 이승진 on 2023/11/14.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!

    var someString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.text = someString
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
