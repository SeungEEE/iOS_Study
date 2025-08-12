//
//  HomeViewModel.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/7/25.
//

import SwiftUI

/// 홈 화면에서 사용되는 ViewModel
@Observable
class HomeViewModel {
    
    // MARK: - Property
    
    /// 전체 광고 등장 상태 변수
    var showAd: Bool = false
    
    /// 배너, 섹션 등의 데이터 합쳐서 구성한 홈 화면 컨텐츠 배열
    var mergedContents: [HomeContentItem] = []
    
    /// 의존성 주입 위한 컨테이너
    let container: DIContainer
    
    
    // MARK: - init
    
    /// DIContainer 받아 초기화하며 더미 데이터 불러옴
    init(container: DIContainer) {
        self.container = container
        self.loadDummyData()
    }
    
    
    // MARK: - Method
    
    /// 배너와 특정 인덱스에 섹션을 삽입하는 방식으로 컨텐츠 생성
    private func loadDummyData() {
        // 배너 데이터
        let banners = BannerDataSource.bannerItems
        
        // 커피 데이터
        let coffees = CoffeeDataSource.summaryItems
        
        // 새소식 데이터
        let newReleases = NewReleaseDataSource.newReleaseItem
        
        // 디저트 데이터
        let desserts = DessertDataSource.dessertItems
        
        // 최종 컨텐츠 배열
        var merged: [HomeContentItem] = []
        
        // 배너 인덱스 추적
        var bannerIndex = 0
        
        // 특정 인덱스에 삽입될 섹션들
        let sectionInsertIndices: [Int: HomeSection] = [
            2: .init(title: "님을 위한 추천메뉴", items: coffees, contentType: .coffee),
            4: .init(title: "What's New", items: newReleases, contentType: .newRelease),
            9: .init(title: "하루가 달콤해지는 디저트", items: desserts, contentType: .dessert)
        ]
        
        for i in 0..<(banners.count + sectionInsertIndices.count) {
            if let section = sectionInsertIndices[i] {
                // 지정된 위치에 섹션 삽입
                merged.append(.section(section))
            } else if bannerIndex < banners.count {
                // 그 외에는 배너 삽입
                merged.append(.banner(banners[bannerIndex]))
                bannerIndex += 1
            }
        }
        
        self.mergedContents = merged
    }
}
