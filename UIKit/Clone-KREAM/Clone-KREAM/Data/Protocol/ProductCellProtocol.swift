//
//  ProductCellProtocol.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/18/24.
//

import UIKit

/// 상품 셀 사용할 프로토콜
protocol ProductCellProtocol {
    var imageView: UIImageView { get }
    var titleLabel: UILabel { get }
    var priceLabel: UILabel { get }
    
    func configure(model: RequiredCellProtocol)
}
