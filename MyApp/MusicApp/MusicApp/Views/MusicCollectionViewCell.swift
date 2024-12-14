//
//  MusicCollectionViewCell.swift
//  MusicApp
//
//  Created by 이승진 on 2024/05/11.
//

import UIKit
import SnapKit

class MusicCollectionViewCell: UICollectionViewCell {
    
    let mainImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // 이미지나 URL을 전달받는 속성
    var imageUrl: String? {
        didSet {
            loadImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
        setConstraints()
    }
    
    func setUp() {
        self.addSubview(mainImageView)
    }
    
    func setConstraints() {
        mainImageView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.leading.equalToSuperview().offset(20)
        }
    }
    
    // URL ==> 이미지를 셋팅하는 메서드
    private func loadImage() {
        guard let urlString = imageUrl, let url = URL(string: urlString) else { return }
        
        // 오래걸리는 작업을 동시성 처리 (다른 쓰레드에서 일시킴)
        DispatchQueue.main.async {
            // URL을 가지고 데이터를 만드는 메서드 (오래걸리는데 동기적인 실행)
            // (일반적으로 이미지를 가져올 때 많이 사용)
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거
            guard urlString == url.absoluteString else { return }
            
            // 작업의 결과물을 이미지로 표시 (메인큐)
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
