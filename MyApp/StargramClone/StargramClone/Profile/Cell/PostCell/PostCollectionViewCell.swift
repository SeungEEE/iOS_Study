//
//  PostCollectionViewCell.swift
//  StargramClone
//
//  Created by 이승진 on 2023/10/16.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCollectionViewCell"
    
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // public으로 선언
    public func setupData() {
        // 이미지뷰의 이미지를 업로드함
        
    }
}
