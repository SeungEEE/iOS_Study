//
//  Store.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 5/19/25.
//

import Foundation
import CoreLocation

// MARK: - FeatureCollection: StoreCollection
struct StoreCollection: Codable {
    let type, name: String
    let features: [Store]
}

// MARK: - Feature: Store
struct Store: Codable, Identifiable {
    var id = UUID()
    let type: String
    let properties: StoreDetail
    let geometry: Geometry
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: String
    let coordinates: [Double]
}

// MARK: - Properties: StoreDetail
struct StoreDetail: Codable {
    let seq, sotreNm, address: String
    let telephone: String
    let category: StoreCategory
    let ycoordinate, xcoordinate: Double

    enum CodingKeys: String, CodingKey {
        case seq = "Seq"
        case sotreNm = "Sotre_nm"
        case address = "Address"
        case telephone = "Telephone"
        case category = "Category"
        case ycoordinate = "Ycoordinate"
        case xcoordinate = "Xcoordinate"
    }
}

enum StoreCategory: String, Codable {
    case reserveShop = "리저브 매장"
    case dtrShop = "DTR 매장"
    case dtShop = "DT 매장"
    case empty = ""
    
    var icons: [String] {
        switch self {
        case .reserveShop:
            return ["reserveIcon"]
        case .dtShop:
            return ["dtIcon"]
        case .dtrShop:
            return ["reserveIcon", "dtIcon"]
        case .empty:
            return []
        }
    }
}

