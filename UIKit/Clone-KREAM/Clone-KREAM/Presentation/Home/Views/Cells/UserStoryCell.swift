//
//  UserStoryCell.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/29/24.
//

import UIKit
import Then
import SnapKit

class UserStoryCell: BaseCollectionViewCell {
    static let identifier = "UserStoryCell"
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageViewCorner(cornerRadius: 10)
        changeLabelColor()
        setup()
        setConstriants()
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    /// 계정 라벨 색 변경
    private func changeLabelColor() {
        self.subTitleLabel.textColor = .white
    }
    
    private func setup() {
        [imageView, subTitleLabel].forEach { addSubview($0) }
    }
    
    private func setConstriants() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(11)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.greaterThanOrEqualTo(60)
            $0.height.equalTo(14)
        }
    }
    
    override func configure(model: any RequiredCellProtocol) {
        guard let userStoryModel = model as? UserStoryModel else { return }
        
        imageView.image = UIImage(named: userStoryModel.imageView)
        subTitleLabel.text = userStoryModel.userName
    }
}
