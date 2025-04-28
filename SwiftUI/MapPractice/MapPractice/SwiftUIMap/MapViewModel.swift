//
//  MapViewModel.swift
//  MapPractice
//
//  Created by 이승진 on 4/26/25.
//

import SwiftUI
import MapKit
import Observation

@Observable
final class MapViewModel {
    
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var currentMapCenter: CLLocationCoordinate2D?
    
    var searchResults: [Place] = []
    
    var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    // 마커
    var markers: [Marker] = [
        .init(coordinate: .init(latitude: 36.014277, longitude: 129.325704), title: "포항공과대학교 C5"),
        .init(coordinate: .init(latitude: 36.015698, longitude: 129.322640), title: "포항공과대학교 지곡회관")
    ]
    
    let geofenceCoordinate = CLLocationCoordinate2D(latitude: 36.013024, longitude: 129.326010)
    let geofenceRadius: CLLocationDistance = 100
    let geofenceIdentifier = "포항공대"
    
    init() {
        LocationManager.shared.startMonitoringGeofence(center: geofenceCoordinate, radius: geofenceRadius, identifier: geofenceIdentifier)
    }
    
    func search(query: String, to location: CLLocation) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = .init(center: location.coordinate, span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let self, let mapItems = response?.mapItems else { return }
            
            DispatchQueue.main.async {
                self.searchResults = mapItems.map { Place(mapItem: $0) }
            }
        }
    }
}
