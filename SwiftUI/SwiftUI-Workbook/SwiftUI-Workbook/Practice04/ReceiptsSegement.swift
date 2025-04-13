//
//  ReceiptsSegement.swift
//  SwiftUI-Workbook
//
//  Created by 이승진 on 4/12/25.
//

import Foundation

enum ReceiptsSegement: Int, CaseIterable, Identifiable {
    case first
    case second
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .first:
            return "첫 번째"
        case .second:
            return "두 번째"
        }
    }
    
    var imageName: String {
        switch self {
        case .first:
            return "first"
        case .second:
            return "second"
        }
    }
}
