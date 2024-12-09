//
//  UIView+Extension.swift
//  StargramClone
//
//  Created by 이승진 on 2023/10/05.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat { // Interface 항목추가 , 모따기
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
