//
//  SearchView.swift
//  Clone-KREAM
//
//  Created by 이승진 on 2/10/25.
//

import UIKit
import SnapKit
import Then

class SearchView: UIView {
    
    /// 검색 버튼 터치시 처리하는 함수
    var onSearchButtonTapped: ((String) -> Void)?
    
    
    // MARK: - UI Components
    
    /// 상단 검색바
    public lazy var searchBar = UISearchBar().then {
        $0.placeholder = "브랜드, 상품, 프로필, 태그 등"
        $0.showsCancelButton = true
    }
    
    /// 최근 검색 라벨
    private lazy var recentSearchLabel = UILabel().then {
        $0.text = "추천 검색어"
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textColor = .black
    }
    
    private lazy var recentSearchStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .fill
    }
    
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        changeCancelKorean()
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Function
    
    /// 기본적으로 검색바 만들면 취소 버튼이 아닌, cancel이라고 영어로 등장, 이를 취소 버튼으로 재생성
    private func changeCancelKorean() {
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("취소", for: .normal)
        }
    }
    
    /// 스택뷰 한 행에 대한 스택뷰를 넣어서 최근 검색어 관리. 한 줄에 최대 5개의 최근 검색어를 넣을 수 있음
    /// - Parameter searches: 최근 검색 단어들 배열값
    public func updateRecentSearchButton(_ searches: [String]) {
        recentSearchStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let maxButtonPerRow = 5 // 최대 5개
        var currentRowStackView: UIStackView?
        
        for (index, keyword) in searches.enumerated() {
            if index % maxButtonPerRow == 0 {
                currentRowStackView = UIStackView()
                currentRowStackView?.axis = .horizontal
                currentRowStackView?.spacing = 3
                currentRowStackView?.alignment = .center
                currentRowStackView?.distribution = .fillEqually
                
                if let rowStack = currentRowStackView {
                    recentSearchStackView.addArrangedSubview(rowStack)
                }
            }
            
            let button = UIButton()
            
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 11, bottom: 8, trailing: 11)
            button.configuration = configuration
            
            button.setTitle(keyword, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
            button.setTitleColor(.black, for: .normal)
            
            button.backgroundColor = .systemGray5
            
            button.addAction(UIAction{ [weak self] _ in
                self?.onSearchButtonTapped?(keyword)
            }, for: .touchUpInside)
            
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 20
            
            currentRowStackView?.addArrangedSubview(button)
        }
    }
    
    private func setup() {
        self.backgroundColor = .white
        
        [recentSearchLabel, recentSearchStackView].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        recentSearchLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(69)
            $0.height.equalTo(18)
        }
        
        recentSearchStackView.snp.makeConstraints {
            $0.top.equalTo(recentSearchLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(100)
            $0.height.equalTo(20)
        }
    }
}
