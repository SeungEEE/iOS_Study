//
//  ProductCell.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/29/24.
//

import UIKit
import Then
import SnapKit

class ProductCell: BaseCollectionViewCell {
    static let identifier = "ProductCell"
    
    // MARK: - UI Component
    
    /// 상품 수 라벨
    private lazy var productCount: UILabel = makeLabel(font: .systemFont(ofSize: 10, weight: .regular), color: UIColor(red: 0.251, green: 0.272, blue: 0.294, alpha: 1))
    
    /// 이미지 백그라운드 랜덤 색상
    private lazy var imageBackgroundColor = UIView().then {
        $0.backgroundColor = UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 0.5
        )
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
    }
    
    /// 태그 버튼
    private lazy var tagButton = UIButton().then {
        $0.tintColor = .black
    }
    
    /// "즉시 구매가" 라벨
    private lazy var priceDescription = UILabel().then {
        $0.text = "즉시 구매가"
        $0.font = .systemFont(ofSize: 10, weight: .light)
        $0.textColor = UIColor(red: 0.635, green: 0.635, blue: 0.635, alpha: 1)
    }
    
    /// 상품 이름 및 설명 스택뷰
    private lazy var productTitleStack: UIStackView = makeStackView(spacing: 3)
    
    /// 상품 가격 및 "즉시 구매가" 스택뷰
    private lazy var priceTitleStack: UIStackView = makeStackView(spacing: 2)
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setConstraints()
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        productCount.text = nil
        tagButton.setImage(nil, for: .normal)
        
        titleLabel.text = nil
        subTitleLabel.text = nil
        
        priceLabel.text = nil
        priceDescription.text = nil
    }
    
    // MARK: - Function
    private func setTagButtonImage(isMark: Bool) -> UIImage {
        if isMark {
            return UIImage(systemName: "bookmark") ?? UIImage()
        } else {
            return UIImage(systemName: "bookmark.fill") ?? UIImage()
        }
    }
    
    private func setup() {
        // 스택뷰 추가
        [priceLabel, priceDescription].forEach { priceTitleStack.addArrangedSubview($0) }
        [titleLabel, subTitleLabel].forEach { productTitleStack.addArrangedSubview($0) }
        
        // 컴포넌트 추가
        [imageView, productCount, tagButton].forEach { imageBackgroundColor.addSubview($0) }
        [productTitleStack, priceTitleStack, imageBackgroundColor].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        imageBackgroundColor.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(142)
        }
        
        productCount.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(-8)
            $0.width.greaterThanOrEqualTo(48)
            $0.height.equalTo(12)
        }
        
        tagButton.snp.makeConstraints {
            $0.top.equalTo(productCount.snp.bottom).offset(92)
            $0.leading.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(14.2)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.lessThanOrEqualTo(123)
            $0.height.greaterThanOrEqualTo(30)
        }
        
        productTitleStack.snp.makeConstraints {
            $0.top.equalTo(imageBackgroundColor.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(2)
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualTo(25)
        }
        
        titleLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(14)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualTo(14)
        }
        
        priceTitleStack.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(2)
            $0.width.equalToSuperview()
            $0.height.equalTo(30)
        }
    }
    
    override func configure(model: any RequiredCellProtocol) {
        guard let productModel = model as? ProductModel else { return }
        
        self.imageView.image = UIImage(named: productModel.imageView)
        self.productCount.text = productModel.productCount
        self.tagButton.setImage(setTagButtonImage(isMark: productModel.selectedTag), for: .normal)
        
        self.titleLabel.text = productModel.titleLabel
        self.subTitleLabel.text = productModel.subTitleLabel
        
        self.priceLabel.text = productModel.priceLabel
        self.priceDescription.text = productModel.priceSubLabel
    }
}
