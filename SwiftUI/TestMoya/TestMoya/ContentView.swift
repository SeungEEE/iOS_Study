//
//  ContentView.swift
//  TestMoya
//
//  Created by 이승진 on 5/21/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ForEach(ButtonInfoList.buttonList, id: \.id) { button in
                Button {
                    button.action()
                } label: {
                    Text(button.title)
                }
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
    static let serviceManager: ContentViewModel = .init()
    static let buttonList: [ButtonInfo] = [
        .init(title: "GET", action: {
            serviceManager.getUserData(name: "이안")
        }),
        .init(title: "POST", action: {
            serviceManager.createUser(.init(name: "이안", age: 25, address: "포항시 효곡동", height: 171))
        }),
        .init(title: "PATCH", action: {
            serviceManager.updateUserPatch(.init(name: nil, age: 20, address: nil, height: nil))
        }),
        .init(title: "PUT", action: {
            serviceManager.updateUserPut(.init(name: "Ian", age: 29, address: "서울특별시", height: 177))
        }),
        .init(title: "DELETE", action: {
            serviceManager.deleteUser(name: "이안")
        })
    ]
}

#Preview {
    ContentView()
}
