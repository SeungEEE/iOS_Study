//
//  FourthViewController.swift
//  NextVC
//
//  Created by 이승진 on 2023/11/15.
//

import UIKit

class FourthViewController: UIViewController {
    
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
