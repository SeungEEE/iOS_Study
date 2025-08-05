//
//  MenuItemAttr.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/3/25.
//

import SwiftUI

/// 메뉴 아이템이 공통적으로 가져야 하는 속성을 정의한 프로토콜
protocol MenuItemAttr {
    
    /// 메뉴 이름
    var name: String { get }
    
    /// 썸네일로 사용할 이미지 리소스
    var thumbnailImage: ImageResource { get }
}
