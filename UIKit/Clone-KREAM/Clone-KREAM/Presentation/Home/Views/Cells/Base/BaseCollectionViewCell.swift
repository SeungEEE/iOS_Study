//
//  BaseCollectionViewCell.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/18/24.
//

import UIKit
import Then
import SnapKit

class BaseCollectionViewCell: UICollectionViewCell, ProductCellProtocol {
    
    // MARK: - UI Compoenets

    /// 상품 이미지
    lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    /// 상품 타이틀
    lazy var titleLabel: UILabel = makeLabel(font: .systemFont(ofSize: 12, weight: .semibold), color: .black)
    
    /// 상품 서브 타이틀
    lazy var subTitleLabel: UILabel = makeLabel(font: .systemFont(ofSize: 12, weight: .regular), color: .black)
    
    /// 상품 가격
    lazy var priceLabel: UILabel = makeLabel(font: .systemFont(ofSize: 12, weight: .semibold), color: .black)
    
    override func prepareForReuse() {
        imageView.image = nil
        titleLabel.text = nil
        subTitleLabel.text = nil
        priceLabel.text = nil
    }
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function

    /// 중복 라벨 처리 함수
    func makeLabel(font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }
    
    /// 스택뷰 생성
    func makeStackView(spacing: CGFloat) -> UIStackView {
        let sv = UIStackView()
        sv.spacing = spacing
        sv.axis = .vertical
        sv.distribution = .fill
        return sv
    }
    
    /// 이미지의 cornerRadius 수정할 경우 사용
    func imageViewCorner(cornerRadius: CGFloat) {
        imageView.layer.cornerRadius = cornerRadius
    }
    
    /// 셀 내부 컴포넌트 값 할당 함수
    func configure(model: any RequiredCellProtocol) {
        print("상속 받은 셀에서 오버라이드 하여 사용할 것")
    }
}
