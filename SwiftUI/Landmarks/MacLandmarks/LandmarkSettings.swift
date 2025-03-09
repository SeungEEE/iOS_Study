//
//  LandmarkSettings.swift
//  MacLandmarks
//
//  Created by 이승진 on 3/9/25.
//

import SwiftUI

struct LandmarkSettings: View {
    @AppStorage("MapView.zoom")
    private var zoom: MapView.Zoom = .medium
    
    var body: some View {
        Form {
            Picker("Map Zoom", selection: $zoom) {
                ForEach(MapView.Zoom.allCases) { level in
                    Text(level.rawValue)
                }
            }
            .pickerStyle(.inline)
        }
        .frame(width: 300)
        .navigationTitle("Landmark Settings")
        .padding(80)
    }
}

#Preview {
    LandmarkSettings()
}
