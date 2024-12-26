//
//  SectionSeparatorFooter.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/26/24.
//

import UIKit
import SnapKit
import Then

class SectionSeparatorFooter: UICollectionReusableView {
    static let identifier = "SectionSeparatorFooter"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(separator)
        separator.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 구분선
    lazy var separator = UIView().then {
        $0.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
    }
}
