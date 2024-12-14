//
//  DiceModel.swift
//  iOS-WorkBook
//
//  Created by 이승진 on 12/14/24.
//

import Foundation

struct DiceModel {
    let diceImage: String
    let diceName: String
}

final class dummyDiceModel {
    static let diceDatas: [DiceModel] = [
        DiceModel(diceImage: "dice 1", diceName: "주사위 1"),
        DiceModel(diceImage: "dice 2", diceName: "주사위 2"),
        DiceModel(diceImage: "dice 3", diceName: "주사위 3"),
        DiceModel(diceImage: "dice 4", diceName: "주사위 4"),
        DiceModel(diceImage: "dice 5", diceName: "주사위 5"),
        DiceModel(diceImage: "dice 6", diceName: "주사위 6")
    ]
}
