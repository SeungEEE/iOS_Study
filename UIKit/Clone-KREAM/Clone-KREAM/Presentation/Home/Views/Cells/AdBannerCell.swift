//
//  AdBannerCell.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/18/24.
//

import UIKit
import SnapKit

class AdBannerCell: BaseCollectionViewCell {
    static let identifier = "AdBannerCell"
    
    override func prepareForReuse() {
        self.imageView.image = nil
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setConstraints()
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setup() {
        addSubview(imageView)
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func configure(model: any RequiredCellProtocol) {
        guard let adBannerModel = model as? AdBannerModel else { return }
        
        imageView.image = UIImage(named: adBannerModel.imageView)
    }
}
