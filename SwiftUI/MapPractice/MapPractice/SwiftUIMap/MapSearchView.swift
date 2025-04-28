//
//  MapSearchView.swift
//  MapPractice
//
//  Created by 이승진 on 4/28/25.
//

import SwiftUI
import MapKit

struct MapSearchView: View {
    @Bindable private var viewModel: MapViewModel = .init()
    @Bindable private var locationManager: LocationManager = .shared
    @State private var searchText = ""

    var body: some View {
        VStack {
            TextField("장소를 검색하세요", text: $searchText, onCommit: {
                if let location = locationManager.currentLocation {
                    viewModel.search(query: searchText, to: location)
                }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            Map(position: $viewModel.cameraPosition, bounds: .none, interactionModes: .all, content: {
                ForEach(viewModel.searchResults, id: \.id, content: { place in
                    if let coordinate = place.mapItem.placemark.location?.coordinate {
                        Annotation(place.mapItem.name ?? "이름없음", coordinate: coordinate, content: {
                            Image(systemName: "mappin")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color.red)
                        })
                    }
                })
                
            })
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()

            List(viewModel.searchResults) { place in
                VStack(alignment: .leading) {
                    Text(place.mapItem.name ?? "이름 없음")
                        .font(.headline)
                    Text(place.mapItem.placemark.title ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    MapSearchView()
}

