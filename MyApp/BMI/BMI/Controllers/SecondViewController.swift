//
//  SecondViewController.swift
//  BMI
//
//  Created by 이승진 on 2023/11/20.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // 전화면에서 전달받은 데이터들
//    var bmiNumber: Double?
//    var adviceString: String?
//    var bmiColor: UIColor?
    
    var bmi: BMI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureUI()
        
        // 전화면에서 전달 받은 데이터들을 통해 셋팅
        guard let bmi = bmi else { return }
        
        bmiNumberLabel.text = "\(bmi.value)"
        bmiNumberLabel.backgroundColor = bmi.matchColor
        adviceLabel.text = bmi.advice
    }
    
    func configureUI() {
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        
        backButton.layer.cornerRadius = 5
    }
    
    // 다시 계산하기 버튼 눌렀을 때
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // 뒤로가기
        dismiss(animated: true, completion: nil)
    }
}
