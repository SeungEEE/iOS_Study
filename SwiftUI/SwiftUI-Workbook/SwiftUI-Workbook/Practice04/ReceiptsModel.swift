//
//  ReceiptsModel.swift
//  SwiftUI-Workbook
//
//  Created by 이승진 on 4/12/25.
//

import Foundation
import SwiftData

@Model
class ReceiptsModel {
    @Attribute(.unique) var id: UUID // 고유 식별자 (DB 기본키처럼 동작)
    
    var orderer: String      // 주문자
    var store: String        // 장소
    var menuItems: [String]  // 마신 음료
    var totalAmount: Int     // 결제 금액
    var orderNumber: String  // 주문 번호
    var createAt: Date       // 저장된 시점
    
    init(
        orderer: String,
        store: String,
        menuItems: [String],
        totalAmount: Int,
        orderNumber: String,
        createAt: Date = Date()
    ) {
        self.id = UUID()
        self.orderer = orderer
        self.store = store
        self.menuItems = menuItems
        self.totalAmount = totalAmount
        self.orderNumber = orderNumber
        self.createAt = createAt
    }
}
