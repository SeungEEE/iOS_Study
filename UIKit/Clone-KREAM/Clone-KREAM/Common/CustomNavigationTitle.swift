//
//  CustomNavigationTitle.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/15/25.
//

import UIKit
import Then
import SnapKit

class CustomNavigationTitle: UIView {
    let titleText: String
    let subTitleText: String?
    
    // MARK: - UI Component
    
    /// 타이틀 라벨
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15, weight: .bold)
    }
    
    /// 서브 타이틀 라벨
    private lazy var subTitleLabel = UILabel().then {
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 10, weight: .regular)
    }
    
    /// titleLabel + subTitleLabel
    private lazy var titleStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 2
        $0.alignment = .center
    }
    
    // MARK: - init
    
    init(frame: CGRect, titleText: String, subTitleText: String?) {
        self.titleText = titleText
        self.subTitleText = subTitleText
        super.init(frame: frame)
        
        setTitle(title: titleText, subTitle: subTitleText)
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    private func setTitle(title: String, subTitle: String?) {
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle ?? nil
    }
    
    private func setup() {
        [titleLabel, subTitleLabel].forEach { titleStack.addArrangedSubview($0) }
        addSubview(titleStack)
    }
    
    private func setConstraints() {
        titleStack.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
