//
//  RecommendationCell.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/18/24.
//

import UIKit
import Then
import SnapKit

class RecommendationCell: BaseCollectionViewCell {
    static let identifier = "RecommendationCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = nil
    }
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        changeFont()
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    private func changeFont() {
        titleLabel.font = .systemFont(ofSize: 11.5, weight: .regular)
    }
    
    private func setup() {
        [imageView, titleLabel].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(61)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(6)
            $0.centerX.equalTo(imageView.snp.centerX)
            $0.width.lessThanOrEqualTo(65)
            $0.height.equalTo(14)
        }
    }
    
    /// RequiredCellProtocol 상속 받는 모델 값을 파라미터로 전달하여 셀 값에 넣어줌
    override func configure(model: any RequiredCellProtocol) {
        guard let recommendationModel = model as? RecommendationModel else { return }
        
        imageView.image = UIImage(named: recommendationModel.imageView)
        titleLabel.text = recommendationModel.titleLabel
    }
}
