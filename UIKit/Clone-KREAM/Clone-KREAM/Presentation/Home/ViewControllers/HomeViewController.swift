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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return HomeModel.adBannerData.count
        case 1:
            return HomeModel.recomendationData.count
        case 2:
            return HomeModel.productData.count
        case 3:
            return HomeModel.userStoryData.count
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
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else { return UICollectionViewCell() }
            
            let data = HomeModel.productData
            cell.configure(model: data[indexPath.row])
            
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserStoryCell.identifier, for: indexPath) as? UserStoryCell else { return UICollectionViewCell() }
            
            let data = HomeModel.userStoryData
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
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BaseCellHeader.identifier, for: indexPath) as! BaseCellHeader
            
            if indexPath.section == 2 {
                header.configure(title: "Just Dropped", subTitle: "발매 상품")
            } else if indexPath.section == 3 {
                header.configure(title: "본격 한파대비! 연말 필수템 모음", subTitle: "#해피홀리룩챌린지")
            }
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 2 || section == 3 {
            return CGSize(width: collectionView.bounds.width, height: 50)
        } else {
            return CGSize.zero
        }
    }
}
