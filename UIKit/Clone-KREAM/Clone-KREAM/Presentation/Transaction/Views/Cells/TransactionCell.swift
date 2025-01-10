//
//  TransactionCell.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/10/25.
//

import UIKit
import Then
import SnapKit

class TransactionCell: UICollectionViewCell {
    static let identifier = "TransactionCell"
    
    // MARK: - UI Component
    /// 셀 내부 이미지 버튼
    private lazy var imageView = UIImageView()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setup() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public func configure(model: any RequiredCellProtocol) {
        guard let transactionData = model as? TransactionModel else { return }
        imageView.image = UIImage(named: transactionData.imageView)
    }
}
