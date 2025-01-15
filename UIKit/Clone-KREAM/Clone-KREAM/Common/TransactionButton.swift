//
//  TransactionButton.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/8/25.
//

import UIKit
import Then
import SnapKit

/// 구매, 판매 커스텀 버튼
/// UIView를 상속 받기 때문에 addTarget이 아닌 UITapGesture를 사용해서 Action
class TransactionButton: UIView, TransactionButtonProtocol {
    
    // MARK: - Property
    
    let btnType: TransactionButtonType

    
    // MARK: - UI Components
    
    /// 가격 라벨
    var priceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .semibold)
        $0.textColor = .white
    }
    
    /// 즉시 구매가, 즉시 판매가 라벨
    var subLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10, weight: .regular)
    }
    
    /// 구매, 판매 라벨
    var buttonLeftLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .white
    }
    
    /// priceLabel + subLabel
    var priceInfoStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 2
        $0.distribution = .equalSpacing
        $0.alignment = .leading
    }
    
    // MARK: - init
    
    init(frame: CGRect, btnType: TransactionButtonType) {
        self.btnType = btnType
        super.init(frame: frame)
        
        setConfigure(type: btnType)
        setBackgroundColor(type: btnType)
        
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setup() {
        /// 스택뷰
        [priceLabel, subLabel].forEach { priceInfoStack.addArrangedSubview($0) }
        
        /// 컴포넌트
        [buttonLeftLabel, priceInfoStack].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        buttonLeftLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-15)
            $0.width.equalTo(28)
        }
        
        priceInfoStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalTo(buttonLeftLabel.snp.trailing).offset(21)
            $0.width.greaterThanOrEqualTo(53)
            $0.height.equalTo(30)
        }
    }
    
    private func setConfigure(type: TransactionButtonType) {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        buttonLeftLabel.text = setButtonLeftText(type: type)
        subLabel.textColor = setTextColor(type: type)
    }
    
    private func setButtonLeftText(type: TransactionButtonType) -> String {
        switch type {
        case .purchase:
            return "구매"
        case .sell:
            return "판매"
        }
    }
    
    private func setTextColor(type: TransactionButtonType) -> UIColor {
        switch type {
        case .purchase:
            return UIColor(red: 0.639, green: 0.216, blue: 0.137, alpha: 1)
        case .sell:
            return UIColor(red: 0.122, green: 0.467, blue: 0.271, alpha: 1)
        }
    }
    
    private func setBackgroundColor(type: TransactionButtonType) {
        switch type {
        case .purchase:
            self.backgroundColor = UIColor(red: 0.937, green: 0.384, blue: 0.329, alpha: 1)
        case .sell:
            self.backgroundColor = UIColor(red: 0.255, green: 0.725, blue: 0.478, alpha: 1)
        }
    }
}
