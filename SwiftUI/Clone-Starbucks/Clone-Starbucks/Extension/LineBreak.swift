//
//  LineBreak.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/3/25.
//

import SwiftUI

/// 커스텀 줄바꿈 처리를 위한 기능 확장
extension String {
    
    /// 문자열의 모든 글자 사이에 유니코드 zero-width space(\u{200B})를 사입하는 함수
    func customLineBreak() -> String {
        return self.split(separator: "").joined(separator: "\u{200B}")
    }
}
