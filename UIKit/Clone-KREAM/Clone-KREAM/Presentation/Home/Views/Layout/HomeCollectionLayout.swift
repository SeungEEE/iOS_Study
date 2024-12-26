//
//  HomeCollectionLayout.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/24/24.
//

import UIKit

class HomeCollectionLayout {
    
    /// 컬렉션 뷰가 가지는 레이아웃 지정
    /// - Returns: 4가지 섹션, 해당 케이스에 맞춰 섹션 반환되도록 레이아웃 생성
    static func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return createBannerSection()
            case 1:
                return createRecommendationSection()
            default:
                return nil
            }
        }
    }
    
    /// 배너 섹션 생성
    private static func createBannerSection() -> NSCollectionLayoutSection {
        /// itemSize: 셀 하나의 아이템
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(336))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        /// 셀 담는 전체 그룹
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(336))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        /// 섹션 크기 지정
        /// 헤더 + 셀 부분 + 푸터
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    /// 추천 섹션 생성
    private static func createRecommendationSection() -> NSCollectionLayoutSection {
        /// 1줄에 5개, 총 2줄
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .absolute(81))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        /// 1줄당 1그룹
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(91))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(8)
        
        /// 섹션 크기 지정
        /// 헤더 + 셀 부분 + 푸터
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 30, trailing: 15)
        section.boundarySupplementaryItems = [createFooterItem()]
        
        return section
    }
    /// 푸터 생성
    private static func createFooterItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        /// 구분선 길이
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(1))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        return footer
    }
}
