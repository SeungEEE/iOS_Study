//
//  SelectSizeView.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/10/25.
//

import UIKit
import Then
import SnapKit

class SelectSizeView: UIView {
    
    // MARK: - UI Component
    
    /// 상품 이미지
    private lazy var productImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    /// 상품 이름
    private lazy var productNameLabel = makeLabel("aaaa", .systemFont(ofSize: 14, weight: .regular), color: .black)
    
    /// 상품 설명
    private lazy var productDescription = makeLabel("bbbbb", .systemFont(ofSize: 12, weight: .regular), color: .gray)
    
    /// 상품 사이즈 버튼 컬렉션뷰
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SizeCell.self, forCellWithReuseIdentifier: SizeCell.identifier)
        return collectionView
    }()
    
    /// 빠른 배송 버튼
    public lazy var speedButton: ShippingButton = makeButton(price: "345,000", type: .speed)
    
    /// 일반 배송 버튼
    public lazy var normalButton: ShippingButton = makeButton(price: "407,000", type: .normal)
    
    /// 바텀 백그라운드 뷰
    private lazy var backgroundView: TransactionBottomBackground = TransactionBottomBackground()

    /// productNameLabel + productDescription
    private lazy var productInfoStack: UIStackView = makeStackView(spacing: 4, axis: .vertical)
    
    /// speedButton + normalButton
    private lazy var buttonInfoStacak: UIStackView = makeStackView(spacing: 6, axis: .horizontal)
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function

    public func changeValue(data: ReceiveTransactionData) {
        self.productImageView.image = data.image
        self.productNameLabel.text = data.productName
        self.productDescription.text = data.productDescription
    }
    
    private func setup() {
        /// 스택뷰
        [productNameLabel, productDescription].forEach { productInfoStack.addArrangedSubview($0) }
        [speedButton, normalButton].forEach { buttonInfoStacak.addArrangedSubview($0) }
        
        /// 컴포넌트
        [productImageView, productInfoStack, collectionView, backgroundView].forEach { addSubview($0) }
        backgroundView.addSubview(buttonInfoStacak)
    }
    
    private func setConstraints() {
        productImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(5)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(91)
        }
        
        productInfoStack.snp.makeConstraints {
            $0.centerY.equalTo(productImageView.snp.centerY)
            $0.leading.equalTo(productImageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(35)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.greaterThanOrEqualTo(115)
        }
        
        backgroundView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(95)
        }
        
        buttonInfoStacak.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(342)
            $0.height.equalTo(52)
        }
        
        speedButton.snp.makeConstraints {
            $0.width.equalTo(168)
            $0.height.equalTo(52)
        }
        
        normalButton.snp.makeConstraints {
            $0.width.equalTo(168)
            $0.height.equalTo(52)
        }
    }
    
    // MARK: - Make Function
    private func makeLabel(_ text: String, _ font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        return label
    }
    
    private func makeButton(price: String, type: ShippingButtonType) -> ShippingButton {
        let button = ShippingButton(frame: .zero, btnType: type)
        button.priceLabel.text = price
        button.isUserInteractionEnabled = true
        return button
    }
    
    private func makeStackView(spacing: CGFloat, axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.spacing = spacing
        stack.distribution = .equalSpacing
        return stack
    }
}
