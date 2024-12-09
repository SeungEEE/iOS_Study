//
//  ViewController.swift
//  BMI
//
//  Created by 이승진 on 2023/11/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    var bmiManager = BMICalculatorManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        makeUI()
    }
    
    func makeUI() {
        mainLabel.text = "키와 몸무게를 입력해주세요"
        
        calculateButton.clipsToBounds = true
        calculateButton.layer.cornerRadius = 5
        calculateButton.setTitle("BMI 계산하기", for: .normal)
        
        heightTextField.placeholder = "cm단위로 입려해주세요"
        weightTextField.placeholder = "kg단위로 입력해주세요"
    }
    
    // BMI계산하기 - 버튼 누르면(다음화면)
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
//        // BMI 결과값 뽑기
//        guard let height = heightTextField.text,
//              let weight = weightTextField.text else { return }
        print(#function)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "키와 몸무게를 입력하셔야만 합니다!"
            mainLabel.textColor = .red
            return false
        }
        mainLabel.text = "키와 몸무게를 입력해주세요"
        mainLabel.textColor = .black
        return true
    }
    
    // 다음화면 넘어가기 전에 준비 (일반적으로 데이터 전달)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // 항상 식별자 먼저 확인
        if segue.identifier == "toSecondVC" {
            let secondVC = segue.destination as! SecondViewController
            secondVC.modalPresentationStyle = .fullScreen
            
            secondVC.bmi = bmiManager.getBMI(height: heightTextField.text!, weight: weightTextField.text!)
            
        }
        // 다음 화면으로 가기 전에 텍스트필드 비우기
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if Int(string) != nil || string == "" {
            return true // 글자 입력 허용
        }
        return false // 글자 입력 허용하지 않음
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두 개의 텍스트 필드를 모두 종료(키보드 내려가기)
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
        // 두 번째 텍스트 필드로 넘어가도록
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
}
