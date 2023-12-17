//
//  MyButton.swift
//  ViewCycle
//
//  Created by 이승진 on 2023/12/17.
//

import UIKit

final class MyButton: UIButton {
    
    var onAndOff = false
    
    func toggle() {
        self.onAndOff.toggle()
    }
}
