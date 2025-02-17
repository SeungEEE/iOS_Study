//
//  Kingfisher+.swift
//  Clone-KREAM
//
//  Created by 이승진 on 2/17/25.
//

import UIKit
import Kingfisher

extension UIImageView {
    /// 이미지 주소 값을 넣으면 이미지를 가져와서 지정된 이미지뷰의 이미지로 활용
    /// - Parameter :
    ///     - urlString: 이미지 URL 주소
    ///     - placeholder: 이미지 로딩 되는 동안 보이는 ProgressView 처리
    func setImage(from urlString: String?, placeholder: String = "placeholder") {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = UIImage(named: placeholder)
            return
        }
        self.kf.setImage(with: url, placeholder: UIImage(named: placeholder))
    }
}
