//
//  ShippingButton.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/14/25.
//

import UIKit
import Then
import SnapKit

class ShippingButton: UIView, TransactionButtonProtocol {
    
    // MARK: - Property
    
    let btnType: ShippingButtonType
    
    
    // MARK: - UI Component
    
    /// 가격 라벨
    var priceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = .white
    }
    
    /// 빠른배송, 즉시배송 라벨
    var subLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10, weight: .regular)
        $0.textColor = .white
    }
    
    /// priceLabel + subLabel
    var priceInfoStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 2
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    
    
    // MARK: - init
    
    init(frame: CGRect, btnType: ShippingButtonType) {
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
        addSubview(priceInfoStack)
    }
    
    private func setConstraints() {
        priceInfoStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualTo(53)
            $0.height.equalTo(30)
        }
    }
    
    private func setConfigure(type: ShippingButtonType) {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        subLabel.text = setSubText(type: type)
        subLabel.textColor = setTextColor(type: type)
    }
    
    private func setSubText(type: ShippingButtonType) -> String {
        switch type {
        case .speed:
            return "빠른배송(1~2일 소요)"
        case .normal:
            return "일반배송(5~7일 소요)"
        }
    }
    
    private func setTextColor(type: ShippingButtonType) -> UIColor {
        switch type {
        case .speed:
            return UIColor(red: 1, green: 0.792, blue: 0.725, alpha: 1)
        case .normal:
            return UIColor(red: 0.886, green: 0.886, blue: 0.886, alpha: 1)
        }
    }
    
    private func setBackgroundColor(type: ShippingButtonType) {
        switch type {
        case .speed:
            self.backgroundColor =  UIColor(red: 0.937, green: 0.384, blue: 0.329, alpha: 1)
        case .normal:
            self.backgroundColor =  UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1)
        }
    }
}
