//
//  TeenipingCollectionViewCell.swift
//  iOS-WorkBook
//
//  Created by 이승진 on 12/9/24.
//

import UIKit
import Then
import SnapKit

class TeenipingCollectionViewCell: UICollectionViewCell {
    static let identifier = "TeenipingCollectionViewCell"
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    let titleLabel = UILabel().then {
        $0.text = "티니핑"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 10, weight: .semibold)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        [imageView, titleLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(4)
        }
    }
    
}
