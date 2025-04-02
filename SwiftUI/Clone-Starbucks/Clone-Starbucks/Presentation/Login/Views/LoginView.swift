//
//  LoginView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/17/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    @FocusState private var idIsFocused: Bool
    @FocusState private var pwdIsFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            loginTopTitle
            
            Spacer()
            
            loginCenterTitle
            
            Spacer()
            
            loginBottomTitle
        }
        .safeAreaPadding(EdgeInsets(top: 104, leading: 19, bottom: 0, trailing: 19))
    }
    
    /// 상단 타이틀
    private var loginTopTitle: some View {
        VStack(alignment: .leading, spacing: 19) {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 97, height: 95)
            
            Text("안녕하세요. \n스타벅스입니다.")
                .font(.mainTextExtraBold24)
                .padding(.top, 9)
            
            Text("회원 서비스를 위해 로그인 해주세요")
                .font(.mainTextMedium16)
                .foregroundStyle(.gray01)
        }
    }
    
    /// 로그인 아이디 비밀번호 입력
    private var loginCenterTitle: some View {
        VStack(alignment: .center, spacing: 47) {
            
            TextField("아이디", text: $viewModel.id)
                .padding(.vertical, 8)
                .focused($idIsFocused)
                .overlay (
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(idIsFocused ? .green01 : .gray00),
                    alignment: .bottom
                )
            
            TextField("비밀번호", text: $viewModel.pwd)
                .padding(.vertical, 8)
                .focused($pwdIsFocused)
                .overlay (
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(pwdIsFocused ? .green01 : .gray00),
                    alignment: .bottom
                )
            
            Button {
                print("로그인 버튼입니다.")
            } label: {
                Text("로그인하기")
                    .frame(maxWidth: .infinity)
                    .font(.mainTextMedium16)
                    .foregroundStyle(Color.white)
                    .padding(.top, 12)
                    .padding(.bottom, 15)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.green01)
                    }
            }
        }
    }
    
    /// 이메일 회원가입 + 소셜 로그인 버튼
    private var loginBottomTitle: some View {
        HStack {
            
            Spacer()
            
            VStack(alignment: .center, spacing: 19) {
                Button {
                    print("이메일로 회원가입 버튼입니다.")
                } label: {
                    Text("이메일로 회원가입하기")
                        .font(.mainTextRegular12)
                        .foregroundStyle(.gray04)
                        .underline(color: Color.gray04)
                }
                
                makeButton(image: Image(.loginKakao))
                
                makeButton(image: Image(.loginApple))
            }
            
            Spacer()
        }
    }
    
    private func makeButton(image: Image) -> some View {
        Button {
            print("로그인 버튼입니다.")
        } label: {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 306)
        }
    }
}

//#Preview {
//    LoginView()
//}

struct LoginView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            LoginView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
