//
//  CoffeeMenuItem.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/3/25.
//

import SwiftUI

/// 개별 커피 메뉴 정보 담는 모델
struct CoffeeMenuItem: Identifiable {
    
    /// 고유 식별자
    let id: UUID
    
    /// 커피 이름
    let name: String
    
    /// 커피 영문 이름 or 부제
    let subName: String
    
    /// 가격 (단위: 원)
    let price: Int
    
    /// 온도별 커피 상세 정보 (이미지 + 설명)
    let variants: [CoffeeTemperature: CoffeeVariant]
    
    /// 온도에 따라 라벨 텍스트 반환
    var temperatureLabel: String {
        let temps = Set(availableTemperatures)
        if temps == [.hot] {
            return "Hot Only"
        } else if temps == [.iced] {
            return "ICED Only"
        } else {
            return ""
        }
    }
    
    /// 온도별 이름 및 서브 이름 커스텀
    let temperatureNames: [CoffeeTemperature: (String, String)]?
    
    /// 사용 가능한 온도 리스트 반환
    var availableTemperatures: [CoffeeTemperature] {
        Array(variants.keys)
    }
    
    /// 특정 온도의 커피 상세 정보 반환
    func variants(temp: CoffeeTemperature) -> CoffeeVariant? {
        variants[temp]
    }
}

/// 커피 온도별 상세 정보 구조체
struct CoffeeVariant {
    
    /// 해당 온도에서 보여줄 이미지
    let image: ImageResource
    
    /// 해당 온도에서의 설명
    let description: String
}
