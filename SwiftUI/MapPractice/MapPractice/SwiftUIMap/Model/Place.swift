//
//  Place.swift
//  MapPractice
//
//  Created by 이승진 on 4/28/25.
//

import Foundation
import MapKit

struct Place: Identifiable, Hashable {
    let id = UUID()
    let mapItem: MKMapItem
}
