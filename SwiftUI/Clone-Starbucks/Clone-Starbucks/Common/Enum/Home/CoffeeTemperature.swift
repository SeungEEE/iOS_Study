//
//  CoffeeTemperature.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/3/25.
//

import Foundation

/// 커피 온도 종류 나타내는 열거형
/// String을 원시값으로 사용하여 서버 통신 등에서 문자열로 쉽게 변환하거나 비교
/// CaseIterable을 채택하여 모든 케이스를 배열처럼 순회
/// Equatable, Hashable을 채택하여 비교 및 Set, Dictionary 등에 사용 가능
enum CoffeeTemperature: String, CaseIterable, Equatable, Hashable {
    
    /// 따뜻한 커피
    case hot = "HOT"
    
    /// 차가운 커피
    case iced = "ICED"
}
