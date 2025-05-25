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
        .init(title: "GET", action: {
            Task {
             await serviceManager.getUser()
            }
        }),
        .init(title: "POST", action: {
            serviceManager.createUser(.init(name: "제옹", age: 29, address: "포항시 대잠동", height: 177))
        }),
        .init(title: "PATCH", action: {
            serviceManager.updateUserPatch(.init(name: nil, age: 18, address: nil, height: nil))
        }),
        .init(title: "PUT", action: {
            serviceManager.updateUserPut(.init(name: "JeOng", age: 29, address: "서울시", height: 177))
        }),
        .init(title: "DELETE", action: {
            serviceManager.deleteUser(name: "JeOng")
        }),
    ]
}

#Preview {
    ContentView()
}

