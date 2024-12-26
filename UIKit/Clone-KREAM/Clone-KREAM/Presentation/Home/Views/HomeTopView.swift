//
//  HomeTopView.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/18/24.
//

import UIKit
import Then
import SnapKit

class HomeTopView: UIView, UISearchBarDelegate {

    public var onSearchBarTapped: (() -> Void)?
    
    // MARK: - UI Components
    /// 상단 검색바
    public lazy var searchBar = UISearchBar().then {
        $0.placeholder = "브랜드, 상품, 프로필, 태그 등"
        $0.barTintColor = .white
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.backgroundImage = UIImage()
        $0.delegate = self
        $0.searchTextField.leftView = nil
    }
    
    /// 상단 벨 아이콘
    private lazy var bellImageView = UIImageView().then {
        $0.image = UIImage(systemName: "bell")
        $0.tintColor = .black
    }
    
    /// 상단 세그먼트
    public lazy var segmentControl: HomeSegmentedControl = {
        let items = ["추천", "랭킹", "발매정보", "럭셔리", "남성", "여성"]
        let segmentControl = HomeSegmentedControl(items: items)
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    
    /// 구분선
    private lazy var bottomBorder = UIView().then {
        $0.backgroundColor = .lightGray.withAlphaComponent(0.5)
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setup() {
        [searchBar, bellImageView, segmentControl, bottomBorder].forEach { addSubview($0) }
    }

    private func setConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(bellImageView.snp.leading).offset(-15)
        }
        
        bellImageView.snp.makeConstraints {
            $0.centerY.equalTo(searchBar.snp.centerY)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(24)
        }
        
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(27)
        }
        
        bottomBorder.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(segmentControl.snp.bottom).offset(1)
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        onSearchBarTapped?()
    }
}
