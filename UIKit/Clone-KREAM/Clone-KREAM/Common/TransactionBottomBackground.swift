//
//  TransactionBottomBackground.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/9/25.
//

import UIKit
import Then
import SnapKit

class TransactionBottomBackground: UIView {
    
    // MARK: - UI Component
    
    /// 상단 구분선
    private lazy var topLine = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.addSubview(topLine)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setConstraints() {
        topLine.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
