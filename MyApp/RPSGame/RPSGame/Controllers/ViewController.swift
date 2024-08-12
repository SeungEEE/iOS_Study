//
//  ViewController.swift
//  RPSGame
//
//  Created by 이승진 on 2023/08/30.
//

import UIKit

class ViewController: UIViewController {

    // 변수 / 속성
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var comImageView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var comChoiceLabel: UILabel!
    @IBOutlet weak var myChoiceLabel: UILabel!
    
    // 데이터 저장 위한 변수 (컴퓨터 선택 / 나의 선택)
    var comChoice: Rps = Rps.allCases[Int.random(in: 1...3)]
    var myChoice: Rps = Rps.allCases[Int.random(in: 1...3)]
    
    // 가위바위보 게임(비즈니스 로직) 관리 위한 인스턴스
    var rpsManager = RPSManager()
    
    // 함수 / 메서드
    // 앱의 화면에 들어오면 처음 실행되는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        
       getReady()
    }
    
    @IBAction func rpsButtonTapped(_ sender: UIButton) {
        
        // 가위/바위/보(enum)를 선택해서 그 정보를 저장해야됨
        
        // 버튼의 문자를 가져옴
        guard let title = sender.currentTitle else { return }
        
//        let title = sender.currentTitle!
        print(title)
        
        // 가져온 문자를 분기처리해서 myChoice변수에 열거형 형태로 저장
        myChoice = selectedRPS(withString: title)
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        
        // 1) 컴퓨터가 랜덤 선택한 것을 이미지 뷰에 표시
        // 2) 컴퓨터가 랜덤 선택한 것을 레이블에 표시
        comImageView.image = comChoice.rpsInfo.image
        comChoiceLabel.text = comChoice.rpsInfo.name
        
        // 3) 내가 선택한 것을 이미지 뷰에 표시
        // 4) 내가 선택한 것을 레이블에 표시
        myImageView.image = myChoice.rpsInfo.image
        myChoiceLabel.text = myChoice.rpsInfo.name
        
        // 5) 컴퓨터가 선택한 것과 내가 선택한 것을 비교해서 이겼는지/졌는지/비겼는지 판단/표시
        mainLabel.text = rpsManager.getRpsResult(comChoice: self.comChoice, myChoice: self.myChoice)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        getReady()
        comChoice = Rps.allCases[Int.random(in: 1...3)]
    }
    
    func getReady() {
        mainLabel.text = "선택하세요"
        
        comImageView.image = Rps.ready.rpsInfo.image
        comChoiceLabel.text = Rps.ready.rpsInfo.name
        
        myImageView.image = Rps.ready.rpsInfo.image
        myChoiceLabel.text = Rps.ready.rpsInfo.name
    }
    
    func selectedRPS(withString name: String) -> Rps {
        switch name {
        case "가위":
            return Rps.scissors
        case "바위":
            return Rps.rock
        case "보":
            return Rps.paper
        default:
            return Rps.ready
        }
    }
}
