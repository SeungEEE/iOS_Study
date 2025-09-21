//
//  NavigationDestination.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/3/25.
//

import Foundation

enum NavigationDestination: Equatable, Hashable {
    case signup
    case coffeeDetail(id: UUID)
    case receiptView
    case findStoreView
}
