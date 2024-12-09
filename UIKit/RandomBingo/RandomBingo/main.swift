//
//  main.swift
//  RandomBingo
//
//  Created by 이승진 on 2023/09/04.
//

import Foundation

var computerChoice = Int.random(in: 1...100) // 1~100 까지 랜덤

var myChoice: Int = 0

while true {
    
    var userInput = readLine()  // 숫자 입력 받기, 문자열이기 때문에 숫자로 타입변환 필요
    
    
    
    if let input = userInput { // String? 벗기기
        if let number = Int(input) { // Int? 벗기기
            myChoice = number
        }
    }
    
    //print(myChoice)
    
    
    if computerChoice > myChoice {
        print("Up")
    } else if computerChoice < myChoice {
        print("Down")
    } else { 
        print("Bingo")
        break // 반복문을 종료
    }
}
