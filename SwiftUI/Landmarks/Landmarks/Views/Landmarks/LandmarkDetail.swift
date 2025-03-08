//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by 이승진 on 3/8/25.
//

import SwiftUI

struct LandmarkDetail: View {
    var body: some View {
        VStack{
            MapView()
                .frame(height: 300)
            
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text("Turtle Rock")
                    .font(.title)
                
                HStack {
                    Text("Joshua Tree National Park")
                    Spacer()
                    Text("California")
                } //: HStack
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Divider()
                
                Text("About Turtle Rock")
                    .font(.title2)
                Text("Description text goes here.")
            } //: VStack
            .padding()
            
            Spacer()
            
        } //: VStack
    }
}

#Preview {
    LandmarkDetail()
}
