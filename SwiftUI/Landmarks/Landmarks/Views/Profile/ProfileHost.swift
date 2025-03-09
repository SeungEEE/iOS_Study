//
//  ProfileHost.swift
//  Landmarks
//
//  Created by 이승진 on 3/9/25.
//

import SwiftUI

struct ProfileHost: View {
    @Environment(\.editMode) var editMode
    @Environment(ModelData.self) var modelData
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                EditButton()
            } //: HStack
            
            if editMode?.wrappedValue == .inactive{
                ProfileSummary(profile: modelData.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
            }
        } //: VStack
        .padding()
    }
}

#Preview {
    ProfileHost()
        .environment(ModelData())
}
