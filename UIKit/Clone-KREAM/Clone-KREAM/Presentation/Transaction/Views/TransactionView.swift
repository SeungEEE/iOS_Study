//
//  TransactionView.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/9/25.
//

import UIKit
import Then
import SnapKit

class TransactionView: UIView {
    
    // MARK: - UI Components
    
    /// 선택한 이미지 뷰
    public lazy var productImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    /// 다른 색상의 상품 이미지 처리 컬랙션 뷰
    public lazy var productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 53, height: 53)
        layout.minimumInteritemSpacing = 8
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TransactionCell.self, forCellWithReuseIdentifier: TransactionCell.identifier)
        
        collection.backgroundColor = .white
        return collection
    }()
    
    /// 즉시 구매가 라벨
    private lazy var priceTitleLabel: UILabel = makeLabel("즉시구매가", .systemFont(ofSize: 12, weight: .light), color: .black)
    
    /// 상품 가격 라벨
    private lazy var priceLabel: UILabel = makeLabel("228,000원", .systemFont(ofSize: 20, weight: .semibold), color: .black)
    
    /// 상품 이름 라벨
    public lazy var nameLabel: UILabel = makeLabel("Matin Kim Logo Coating Jumper", .systemFont(ofSize: 16, weight: .regular), color: .black)
    
    /// 상품 설명 (점퍼 색상) 라벨
    public lazy var descriptionLabel: UILabel = makeLabel("마뗑킴 로고 코팅 점퍼 블랙", .systemFont(ofSize: 12, weight: .regular), color: UIColor(red: 0.612, green: 0.612, blue: 0.612, alpha: 1))
    
    /// 하단 태그 버튼
    private lazy var tagButton: UIButton = {
        let btn = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "bookmark")
        configuration.imagePlacement = .top
        configuration.imagePadding = 1
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        configuration.attributedTitle = AttributedString("2,122", attributes: AttributeContainer([.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 12, weight: .regular)]))
        
        btn.configuration = configuration
        btn.tintColor = .black
        return btn
    }()
    
    /// 즉시 구매 버튼
    public lazy var purchaseButton: TransactionButton = makeBtn(price: "345,000", sub: "즉시 구매가", type: .purchase)
    
    /// 즉시 판매 버튼
    public lazy var sellButton: TransactionButton = makeBtn(price: "396,000", sub: "즉시 판매가", type: .sell)
    
    /// 태그 및 버튼 담는 백그라운드 뷰
    private lazy var backgroundView: TransactionBottomBackground = TransactionBottomBackground()
    
    /// priceTitleLabel + priceLabel 스택
    private lazy var priceStack: UIStackView = makeStack(spacing: 4, axis: .vertical)
    
    /// nameLabel + descriptionLabel 스택
    private lazy var productStack: UIStackView = makeStack(spacing: 6, axis: .vertical)
    
    /// 커스텀 버튼 2개 스택
    private lazy var buttonStack: UIStackView = makeStack(spacing: 6, axis: .horizontal)
    
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
    private func makeLabel(_ text: String, _ font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        return label
    }
    
    private func makeBtn(price: String, sub: String, type: TransactionButtonType) -> TransactionButton {
        let btn = TransactionButton(frame: .zero, btnType: type)
        btn.priceLabel.text = price
        btn.subLabel.text = sub
        btn.isUserInteractionEnabled = true
        return btn
    }
    
    private func makeStack(spacing: CGFloat, axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.spacing = spacing
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        return stack
    }
    
    private func setup() {
        /// 스택뷰
        [priceTitleLabel, priceLabel].forEach { priceStack.addArrangedSubview($0) }
        [nameLabel, descriptionLabel].forEach { productStack.addArrangedSubview($0) }
        [purchaseButton, sellButton].forEach { buttonStack.addArrangedSubview($0) }
        
        /// 컴포넌트
        [productImageView, productCollectionView, priceStack, productStack, backgroundView].forEach { addSubview($0) }
        [tagButton, buttonStack].forEach { backgroundView.addSubview($0) }
    }
    
    private func setConstraints() {
        productImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(373)
        }
        
        productCollectionView.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        priceStack.snp.makeConstraints {
            $0.top.equalTo(productCollectionView.snp.bottom).offset(23)
            $0.leading.equalToSuperview().offset(16)
            $0.width.greaterThanOrEqualTo(50)
            $0.height.equalTo(42)
        }
        
        productStack.snp.makeConstraints {
            $0.top.equalTo(priceStack.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(16)
            $0.width.greaterThanOrEqualTo(80)
            $0.height.equalTo(40)
        }
        
        backgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(95)
        }
        
        tagButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(36)
            $0.height.equalTo(38)
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalTo(tagButton.snp.trailing).offset(19)
            $0.width.equalTo(300)
            $0.height.equalTo(49)
        }
        
        purchaseButton.snp.makeConstraints {
            $0.width.equalTo(147)
            $0.height.equalTo(49)
        }
        
        sellButton.snp.makeConstraints {
            $0.width.equalTo(147)
            $0.height.equalTo(49)
        }
    }
}
