//
//  DiceManager.swift
//  DiceGame
//
//  Created by 이승진 on 2023/12/03.
//

import UIKit

struct DiceManager {
    private var diceArray: [UIImage] = [#imageLiteral(resourceName: "black1"), #imageLiteral(resourceName: "black2"), #imageLiteral(resourceName: "black3"), #imageLiteral(resourceName: "black4"), #imageLiteral(resourceName: "black5"), #imageLiteral(resourceName: "black6")]
    
    // 주사위를 랜덤 값으로
    func getRandomDice() -> UIImage {
        return diceArray.randomElement()!
    }
    
    
    func getFirstDice() -> UIImage {
        return diceArray[0]
    }
}
