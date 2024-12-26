//
//  HomeView.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/18/24.
//

import UIKit
import Then
import SnapKit

class HomeView: UIView {
    
    // MARK: - Properties
    public lazy var homeCollectionView: UICollectionView = {
        let layout = HomeCollectionLayout.createCompositionalLayout()
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        
        /// 셀 등록
        collectionView.register(AdBannerCell.self, forCellWithReuseIdentifier: AdBannerCell.identifier)
        collectionView.register(RecommendationCell.self, forCellWithReuseIdentifier: RecommendationCell.identifier)
        
        /// 푸터 등록
        collectionView.register(SectionSeparatorFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SectionSeparatorFooter.identifier)
        collectionView.backgroundColor = .white
        collectionView.refreshControl = refreshControl
        return collectionView
    }()
    
    /// 상단 뷰
    public lazy var homeTopView = HomeTopView()
    
    /// 리프레시 버튼
    private lazy var refreshControl = UIRefreshControl().then {
        $0.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
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
        [homeTopView, homeCollectionView].forEach{ addSubview($0)}
    }
    
    private func setConstraints() {
        homeTopView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        homeCollectionView.snp.makeConstraints {
            $0.top.equalTo(homeTopView.snp.bottom).offset(0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Action
    
    @objc
    private func pullRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.refreshControl.endRefreshing()
        })
    }


}
