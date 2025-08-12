//
//  CoffeeDetailViewModel.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/3/25.
//

import Foundation

/// 커피 상세 화면에서 사용할 ViewModel
@Observable
class CoffeeDetailViewModel {
    
    /// 선택된 커피 메뉴 항목 (id로 조회한 객체)
    let coffee: CoffeeMenuItem
    
    /// 선택한 온도 (HOT or ICED)
    var selectedTemperature: CoffeeTemperature
    
    /// 커피 ID 기반으로 초기화
    /// 해당 ID에 해당하는 커피가 없으면 첫 번째 커피 항목을 기본값으로 설정
    init(coffeeId: UUID) {
        self.coffee = CoffeeDataSource.detailItems.first(where: { $0.id == coffeeId }) ?? CoffeeDataSource.detailItems.first!
        self.selectedTemperature = self.coffee.availableTemperatures.first ?? .iced
    }
    
    /// 현재 선택된 온도에 해당하는 커피 상세 정보 (이미지 , 설명)
    var selectedVariant: CoffeeVariant? {
        coffee.variants(temp: selectedTemperature)
    }
    
    /// 현재 선택된 온도에 따라 표시할 커피 이름
    var currentName: String {
        coffee.temperatureNames?[selectedTemperature]?.0 ?? coffee.name
    }
    
    /// 현재 선택된 온도에 따라 표시할 커피 영어 이름
    var currentSubName: String {
        coffee.temperatureNames?[selectedTemperature]?.1 ?? coffee.subName
    }
}
