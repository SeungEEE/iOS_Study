//
//  BaseCellHeader.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/2/25.
//

import UIKit
import Then
import SnapKit

class BaseCellHeader: UICollectionReusableView, CellHeaderProtocol {
    static let identifier = "BaseCellHeader"
    
    // MARK: - UI Components
    lazy var headerTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .black
    }
    
    lazy var headerSubTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .light)
        $0.textColor = .lightGray
    }
    
    private lazy var headerStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .fillEqually
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setup() {
        [headerTitle, headerSubTitle].forEach { headerStack.addArrangedSubview($0) }
        addSubview(headerStack)
    }
    
    private func setConstraints() {
        headerStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
//        headerTitle.snp.makeConstraints {
//            $0.width.greaterThanOrEqualTo(200)
//            $0.height.equalTo(19)
//        }
//        
//        headerSubTitle.snp.makeConstraints {
//            $0.width.greaterThanOrEqualTo(50)
//            $0.height.equalTo(19)
//        }
    }
    
    public func configure(title:String, subTitle: String) {
        headerTitle.text = title
        headerSubTitle.text = subTitle
    }
}
