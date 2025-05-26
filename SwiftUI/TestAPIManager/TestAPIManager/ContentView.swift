//
//  ContentView.swift
//  TestAPIManager
//
//  Created by 이승진 on 5/22/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 15) {
            ForEach(ButtonInfoList.buttonList, id: \.id) { button in
                Button(action: {
                    button.action()
                }, label: {
                    Text(button.title)
                })
            }
        }
        .padding()
    }
}

struct ButtonInfo: Identifiable {
    var id: UUID = .init()
    var title: String
    var action: () -> Void
}

final class ButtonInfoList {
    
    static let serviceManager: ContentsViewModel = .init()
    
    static let buttonList: [ButtonInfo] = [
        .init(title: "로그인", action: {
            serviceManager.loginAndStoreTokens()
        }),
        .init(title: "GET", action: {
            Task {
                await serviceManager.getUser()
            }
        }),
        .init(title: "POST", action: {
            serviceManager.createUser(.init(name: "이안", age: 25, address: "포항시 효곡동", height: 177))
        }),
        .init(title: "PATCH", action: {
            serviceManager.updateUserPatch(.init(name: nil, age: 18, address: nil, height: nil))
        }),
        .init(title: "PUT", action: {
            serviceManager.updateUserPut(.init(name: "Ian", age: 30, address: "서울시", height: 177))
        }),
        .init(title: "DELETE", action: {
            serviceManager.deleteUser(name: "Ian")
        }),
    ]
}

#Preview {
    ContentView()
}


