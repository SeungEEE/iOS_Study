//
//  ProfileHost.swift
//  Landmarks
//
//  Created by 이승진 on 3/9/25.
//

import SwiftUI

struct ProfileHost: View {
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ProfileSummary(profile: draftProfile)
        } //: VStack
        .padding()
    }
}

#Preview {
    ProfileHost()
        .environment(ModelData())
}
