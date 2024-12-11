//
//  LoginButton.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/11/24.
//

import UIKit

enum LoginButtonType {
    case normal
    case social(image: String, title: String)
}

class LoginButton: UIButton {
    init(type: LoginButtonType) {
        super.init(frame: .zero)
        self.configure(with: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIButton {
    func configure(with type: LoginButtonType) {
        switch type {
        case .normal:
            self.setTitle("로그인", for: .normal)
            self.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
            self.layer.cornerRadius = 8
            self.clipsToBounds = true
            
        case .social(let image, let title):
            var configuration = UIButton.Configuration.plain()
            configuration.image = UIImage(named: image)
            configuration.imagePlacement = .leading
            configuration.imagePadding = 69
            configuration.attributedTitle = AttributedString(title, attributes: AttributeContainer([
                .font: UIFont.systemFont(ofSize: 14, weight: .semibold),
                .foregroundColor: UIColor.black
            ]))
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 11, leading: 17, bottom: 13, trailing: 102)
            self.configuration = configuration
            self.layer.cornerRadius = 8
            self.layer.borderColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1).cgColor
            self.layer.borderWidth = 1
            self.clipsToBounds = true
        }
    }
}
