//
//  SavedCell.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/14/24.
//

import UIKit
import Then
import SnapKit

class SavedCell: UITableViewCell {
    static let identifier = "SavedCell"
    
    // MARK: - UI Components
    /// 물건 이미지
    private lazy var productImageView = UIImageView().then {
        $0.image = UIImage(systemName: "x.circle")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    /// 물건 이름
    private lazy var titleLabel = UILabel().then {
        $0.text = "이름"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.numberOfLines = 2
    }
    
    /// 물건 설명
    private lazy var subTitleLabel = UILabel().then {
        $0.text = "설명"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 9, weight: .regular)
        $0.numberOfLines = 2
    }
    
    /// 이름 + 설명 스택뷰
    private lazy var productStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.alignment = .leading
        $0.distribution = .equalSpacing
    }
    
    /// 북마크
    public lazy var bookMarkButton = UIButton().then {
        $0.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    /// 물건 가격
    private lazy var priceLabel = UILabel().then {
        $0.text = "0원"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.numberOfLines = 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        titleLabel.text = nil
        subTitleLabel.text = nil
        priceLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setup() {
        /// StackView
        [titleLabel, subTitleLabel].forEach { productStackView.addArrangedSubview($0) }
        
        /// Component
        [productImageView, productStackView, bookMarkButton, priceLabel].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        productImageView.snp.makeConstraints {
            $0.width.height.equalTo(72)
            $0.top.equalToSuperview().offset(13)
            $0.leading.equalToSuperview().offset(13)
        }
        
        productStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.leading.equalTo(productImageView.snp.trailing).offset(13)
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.width.equalTo(14)
            $0.height.equalTo(18)
            $0.top.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-17)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(67)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }

    /// Cell 내부 속성 조정 함수, 뷰 컨트롤러 접근
    /// - Parameter model: Cell에 사용하는 더미 데이터 모델
    public func configure(model: SavedModel) {
        self.productImageView.image = UIImage(named: model.imageName)
        self.titleLabel.text = model.description.title
        self.subTitleLabel.text = model.description.subTitle
        self.priceLabel.text = "\(formatPrice(model.price))원"
    }
    
    /// 가격을 3자리마다 쉼표를 찍는 형식으로 변환
    /// - Parameter price: 변환할 가격 (Int)
    /// - Returns: 3자리마다 쉼표가 찍힌 문자열
    private func formatPrice(_ price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
