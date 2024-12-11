//
//  UITextField+.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/10/24.
//

import UIKit

extension UITextField {
    
    /// - Parameters:
    ///   - placeholder: Placeholder 텍스트
    ///   - placeholderColor: Placeholder 텍스트의 색상
    ///   - fontSize: 입력 텍스트의 폰트 크기
    ///   - borderColor: 테두리 색상
    ///   - cornerRadius: 모서리 둥글기
    ///   - padding: 좌우 패딩 크기
    ///   - keyboardType: 키보드 타입 (기본값: .default)
    func applyCustomStyle(
        placeholder: String,
        placeholderColor: UIColor = .gray,
        fontSize: CGFloat = 14,
        borderColor: UIColor = .gray,
        cornerRadius: CGFloat = 8,
        padding: CGFloat = 16,
        keyboardType: UIKeyboardType = .default
    ) {
        // Placeholder 스타일
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor,
            .font: UIFont.systemFont(ofSize: fontSize)
        ]
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        
        // 입력 텍스트 스타일
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = .black
        
        // 테두리 스타일
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        
        // 좌우 패딩 추가
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
        
        // 키보드 타입 설정
        self.keyboardType = keyboardType
    }
}
