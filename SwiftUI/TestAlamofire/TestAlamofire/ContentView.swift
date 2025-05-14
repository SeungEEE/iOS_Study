//
//  ContentView.swift
//  TestAlamofire
//
//  Created by 이승진 on 5/15/25.
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
    
    static let serviceManager: ServiceManager = .init()
    
    static let buttonList: [ButtonInfo] = [
        .init(title: "GET", action: {
            Task {
                await serviceManager.getUser(name: "이안")
            }
        }),
        .init(title: "POST", action: {
            Task {
                await serviceManager.postUser(user: .init(name: "이안", age: 25, address: "포항시 효곡동", height: 171))
                
            }
        }),
        .init(title: "PATCH", action: {
            Task {
                await serviceManager.patchUser(name: "Ian")
            }
        }),
        .init(title: "PUT", action: {
            Task {
                await serviceManager.putUser(user: .init(name: "이안", age: 20, address: "목포시 석현동", height: 180))
            }
        }),
        .init(title: "DELETE", action: {
            Task {
                await serviceManager.deleteUser(name: "이안")
            }
        }),
    ]
}

#Preview {
    ContentView()
}

