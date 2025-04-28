//
//  CustomMapContents.swift
//  MapPractice
//
//  Created by 이승진 on 4/28/25.
//

import SwiftUI

struct CustomMapContents: View {
    
    @Bindable var locationManger =  LocationManager.shared
    
    var body: some View {
        CustomMap(locationManager: locationManger)
        
    }
}

#Preview {
    CustomMapContents()
}
