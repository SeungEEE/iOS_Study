//
//  RPSViewModel.swift
//  RPSGame
//
//  Created by 이승진 on 8/12/24.
//

import UIKit

class RPSViewModel {
    let rpsManager: RPSManagerProtocol // = RPSManager()
    
    // 뷰를 위한 데이터
    private var result: String = "선택하세요" {
        didSet {
            onCompleted(result)
        }
    }
    
    private var comChoice: Rps = Rps.ready
    private var myChocie: Rps = Rps.ready
    
    // Output
    var resultString: String {
        return result
    }
    
    var computerRPSimage: UIImage {
        return comChoice.rpsInfo.image
    }
    
    var computerRPStext: String {
        return comChoice.rpsInfo.name
    }
    
    var userRPSimage: UIImage {
        return myChocie.rpsInfo.image
    }
    
    var userRPStext: String {
        return myChocie.rpsInfo.name
    }
    
    var onCompleted: (String) -> Void = { _ in }
    
    // 의존성 주입할 수 있도록
    init(rpsManager: RPSManagerProtocol) {
        self.rpsManager = rpsManager
    }
    
    // Input
    func reset() {
        comChoice = Rps.ready
        myChocie = Rps.ready
        result = "선택하세요"
    }
    
    func rpsButtonTapped() {
        comChoice = Rps.allCases[Int.random(in: 1...3)]
    }
    
    func userGetSelected(title: String) {
        myChocie = selectedRPS(withString: title)
    }
    
    func selectButtonTapped() {
        result = rpsManager.getRpsResult(comChoice: comChoice, myChoice: myChocie)
    }
    
    // Logic
    private func selectedRPS(withString name: String) -> Rps {
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
