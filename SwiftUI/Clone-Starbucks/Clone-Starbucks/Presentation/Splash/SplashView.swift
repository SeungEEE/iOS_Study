//
//  SplashView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/17/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color(.green01)
            
            Image("logo")
                .frame(width: 168, height: 168)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
