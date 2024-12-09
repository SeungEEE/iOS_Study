//
//  PostCollectionViewCell.swift
//  StargramClone
//
//  Created by 이승진 on 2023/10/16.
//

import UIKit
import Kingfisher

class PostCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCollectionViewCell"
    
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // public으로 선언
    public func setupData(_ imageURLStr: String?) {
        // 이미지뷰의 이미지를 업로드함
        guard let imageURLStr = imageURLStr else { return }
        if let url = URL(string: imageURLStr) {
            postImageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo"))
            
        }
    }
}
