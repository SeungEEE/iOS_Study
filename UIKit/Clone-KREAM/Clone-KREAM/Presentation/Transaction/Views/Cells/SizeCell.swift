//
//  SizeCell.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/13/25.
//

import UIKit
import SnapKit

class SizeCell: UICollectionViewCell {
    static let identifier = "SizeCell"
    
    // MARK: - Property
    
    /// 사이즈 속성을 나타내는 라벨, 피그마 값으로 넣어서 적용
    private lazy var sizeLabel: UILabel = makeLabel(UIFont.systemFont(ofSize: 14, weight: .regular), color: .black)
    
    /// 가격 표시 라벨, 피그마 값으로 넣어서 적용
    private lazy var priceLabel: UILabel = makeLabel(UIFont.systemFont(ofSize: 12, weight: .regular), color: .red)
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        selfSetup()
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    /// 중복되는 라벨 생성 함수
    private func makeLabel(_ font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        return label
    }
    
    /// 사이즈 선택 셀 자체 옵션 설정
    private func selfSetup() {
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
    }
    
    /// 컴포넌트 추가
    private func setup() {
        [sizeLabel, priceLabel].forEach{ self.addSubview($0) }
    }
    
    /// 제약 조건 설정
    private func setConstraints() {
        sizeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualTo(9)
            $0.height.equalTo(17)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(sizeLabel.snp.bottom).offset(1)
            $0.centerX.equalTo(sizeLabel.snp.centerX)
            $0.width.greaterThanOrEqualTo(9)
            $0.height.equalTo(17)
        }
    }
    
    /// 뷰 컨트롤러에서 셀 접근하여 데이터 전달
    /// - Parameter model: SizeModel 타입 파라미터
    public func configure(model: SizeModel) {
        self.sizeLabel.text = model.size
        self.priceLabel.text = model.price
    }
    
    /// 버튼이 선택되었을 때, 선택 해제되었을 때 처리를 위한 함수
    /// - Parameter isSelected: 버튼이 선택되면 true, 해제되면 false
    public func changeOption(isSelected: Bool) {
        if isSelected {
            self.priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            self.sizeLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            self.layer.borderColor = UIColor.black.cgColor
        } else {
            self.priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            self.sizeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            self.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
}
