//
//  ViewController.swift
//  TextFieldProject
//
//  Created by 이승진 on 2023/09/17.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        setup()
    }
    
    func setup() {
        view.backgroundColor = UIColor.gray
        
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.placeholder = "이메일 입력"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.returnKeyType = .next
        
        textField.becomeFirstResponder() // 키보드가 올라가게 함
    }
    
    // 화면의 탭을 감지하는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
//        textField.resignFirstResponder()
    }
    
    // 텍스트필드의 입력을 시작할 때 호출 (시작할지 말지의 여부를 허락하는 함수)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(#function) // 함수의 입력을 출력
        return true
    }
    
    // 시점 - 유저가 텍스트필드의 입력을 시작할 때 호출
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        print("유저가 텍스트필드의 입력을 시작함")
    }
    
    // 텍스트필드의 입력을 삭제할 때 호출 (clearButtonMode 사용할 지 말지의 여부를 허락하는 함수)
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 텍스트필드의 글자 내용이 (한글자 한글자) 입력되거나 지워질 때 호출 (입력 허락 여부)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print(#function)
//        print(string)
//        let maxLength = 10
//        let currentString: NSString = (textField.text ?? "") as NSString
//        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
//
//        return newString.length <= maxLength
        
        // 입력되고 있는 글자가 "숫자"인 경우 입력을 허용하지 않는 논리
        if Int(string) != nil { // (숫자로 변환이 된다면 nil이 아닐테니)
            return false
        } else {
            // 10글자 이상 입력되는 것을 막는 코드
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 10
        }
        
        // 10글자 이상 입력되는 것을 막는 코드 (또다른 구현법)
//        if (textField.text?.count)! + string.count > 10 {
//            return false
//        } else {
//            return true
//        }
        
    }
    
    // 텍스트필드의 엔터키가 눌러지면 다음 동작을 허락할 것인지 말 것인지 (여부)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        
        if textField.text == "" {
            textField.placeholder = "Type Something!"
            return false
        } else {
            return true
        }
    }
    
    // 텍스트필드의 입력이 끝날 때 호출 (끝낼지 말지의 여부를 허락하는 함수)
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 시점 - 텍스트필드의 입력이 실제 끝났을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        print("유저가 텍스트필드의 입력을 끝냄")
    }
    
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        // 키보드가 내려가게
        textField.resignFirstResponder() // resign: 사임하다

    }
}
