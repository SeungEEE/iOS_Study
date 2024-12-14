//
//  MusicCell.swift
//  MusicApp
//
//  Created by 이승진 on 2024/05/11.
//

import UIKit
import SnapKit

final class MusicCell: UITableViewCell {
    static let cellId = "MusicCell"
    
    let mainImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let songNameLabel = {
        let label = UILabel()
        label.text = "Song Name"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let artistNameLabel = {
        let label = UILabel()
        label.text = "artist name"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let albumNameLabel = {
        let label = UILabel()
        label.text = "album name"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let releaseDateLabel = {
        let label = UILabel()
        label.text = "release date"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let stackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        sv.spacing = 6
        return sv
    }()
    
    // 이미지 URL을 전달받는 속성
    var imageUrl: String? {
        didSet {
            loadImage()
        }
    }
    
    // 셀이 재상용되기 전에 호출되는 메서드
    override func prepareForReuse() {
        super.prepareForReuse()
        // 일반적으로 이미지가 바뀌는 것처럼 보이는 현상을 없애기 위해서 실행
        self.mainImageView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
        setConstraints()
    }
    
    func setUp() {
        [songNameLabel, artistNameLabel, albumNameLabel, releaseDateLabel].forEach {
            self.stackView.addArrangedSubview($0)
        }
        
        self.addSubview(mainImageView)
        self.addSubview(stackView)
    }
    
    func setConstraints() {
        mainImageView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.leading.equalToSuperview().offset(20)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.trailing).offset(20)
        }
    }
    
    // URL -> 이미지를 셋팅하는 메서드
    private func loadImage() {
        guard let urlString = self.imageUrl, let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거
            guard urlString == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // 스토리보드 또는 Nib으로 만들 때, 사용하게 되는 생성자 코드
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }
    
}
