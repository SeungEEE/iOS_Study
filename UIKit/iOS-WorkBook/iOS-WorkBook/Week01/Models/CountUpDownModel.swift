//
//  CountUpDownModel.swift
//  iOS-WorkBook
//
//  Created by 이승진 on 12/11/24.
//

import Foundation

struct CountUpDownModel {
    var count: Int = 0
    
    mutating func increaseCount() {
        self.count += 1
    }
    
    mutating func decreaseCount() {
        self.count -= 1
    }
}
