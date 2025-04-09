//
//  DataModel.swift
//  ExtraSwiftData
//
//  Created by 이승진 on 4/9/25.
//

import Foundation
import SwiftData

@Model
class Task {
    @Attribute(.unique) var title: String
    var isDone: Bool
    var createAt: Date
    
    @Transient var isBeingEdited: Bool = false // 현재 편집 중인지 나타내는 임시 상태 변수 생성
    
    init(title: String, isDone: Bool = false, createAt: Date = .now) {
        self.title = title
        self.isDone = isDone
        self.createAt = createAt
    }
}
