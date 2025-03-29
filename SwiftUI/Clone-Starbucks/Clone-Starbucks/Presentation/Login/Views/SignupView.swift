//
//  SignupView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/29/25.
//

import SwiftUI

struct SignupView: View {
    @StateObject private var viewModel = SignupViewModel()
    @FocusState private var nameIsFocused: Bool
    @FocusState private var idIsFocused: Bool
    @FocusState private var pwdIsFocused: Bool
    
    var body: some View {
        VStack {
            signupMainView
            
            Spacer()
            
            signupButton
        }
        .safeAreaPadding(EdgeInsets(top: 210, leading: 19, bottom: 72, trailing: 19))
    }
    
    private var signupMainView: some View {
        VStack(spacing: 49) {
            TextField("닉네임", text: $viewModel.signupModel.nickname)
                .padding(.vertical, 8)
                .focused($nameIsFocused)
                .overlay (
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(nameIsFocused ? .green01 : .gray00),
                    alignment: .bottom
                )
            
            TextField("이메일", text: $viewModel.signupModel.id)
                .padding(.vertical, 8)
                .focused($idIsFocused)
                .overlay (
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(idIsFocused ? .green01 : .gray00),
                    alignment: .bottom
                )
            
            TextField("비밀번호", text: $viewModel.signupModel.pwd)
                .padding(.vertical, 8)
                .focused($pwdIsFocused)
                .overlay (
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(pwdIsFocused ? .green01 : .gray00),
                    alignment: .bottom
                )
        }
    }
    
    private var signupButton: some View {
        Button {
            viewModel.saveUserData()
            print("\(viewModel.signupModel.nickname)")
            print("\(viewModel.signupModel.id)")
            print("\(viewModel.signupModel.pwd)")
        } label: {
            Text("생성하기")
                .frame(maxWidth: .infinity)
                .font(.mainTextMedium18)
                .foregroundStyle(Color.white)
                .padding(.top, 19)
                .padding(.bottom, 19)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.green01)
                }
        }
    }
}

//#Preview {
//    SignupView()
//}

struct SignupView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            SignupView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
