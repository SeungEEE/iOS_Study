//
//  HomeViewController.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/11/24.
//

import UIKit
import Then

class HomeViewController: UIViewController {
    
    private lazy var homeView = HomeView().then {
        $0.backgroundColor = .white
        $0.homeCollectionView.delegate = self
        $0.homeCollectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = homeView
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    /// 섹션 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return HomeModel.adBannerData.count
        case 1:
            return HomeModel.recomendationData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdBannerCell.identifier, for: indexPath) as? AdBannerCell else { return UICollectionViewCell() }
            let data = HomeModel.adBannerData
            cell.configure(model: data[indexPath.row])
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCell.identifier, for: indexPath) as? RecommendationCell else { return UICollectionViewCell() }
            let data = HomeModel.recomendationData
            cell.configure(model: data[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HomeViewController {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionSeparatorFooter.identifier, for: indexPath) as! SectionSeparatorFooter
            return footer
        default:
            return UICollectionReusableView()
        }
    }
}
