//
//  Geo-ReverseGeo.swift
//  MapPractice
//
//  Created by 이승진 on 4/28/25.
//

import SwiftUI
import CoreLocation

struct Geo_ReverseGeo: View {
    var body: some View {
        Text("Hello, World!")
            .task {
                let geocoder = CLGeocoder()
                let addressString = "서울특별시 종로구"

                do {
                    let placemarks = try await geocoder.geocodeAddressString(addressString)
                    if let location = placemarks.first?.location {
                        print("위도: \(location.coordinate.latitude), 경도: \(location.coordinate.longitude)")
                    }
                } catch {
                    print("지오코딩 에러: \(error.localizedDescription)")
                }

                let location = CLLocation(latitude: 37.579617, longitude: 126.977041)

                do {
                    let placemarks = try await geocoder.reverseGeocodeLocation(location)
                    if let placemark = placemarks.first {
                        let address = [
                            placemark.administrativeArea,
                            placemark.locality,
                            placemark.subLocality,
                            placemark.thoroughfare
                        ].compactMap { $0 }.joined(separator: " ")

                        print("주소: \(address)")
                    }
                } catch {
                    print("역지오코딩 에러: \(error.localizedDescription)")
                }
            }
    }
}

#Preview {
    Geo_ReverseGeo()
}

