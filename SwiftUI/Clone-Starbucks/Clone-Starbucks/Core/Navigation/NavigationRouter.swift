//
//  NavigationRouter.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/3/25.
//

import Foundation

@Observable
class NavigationRouter: NavigationRoutable {
    
    /// 현재까지 쌓인 화면 목적지 목록 (화면 전환 상태)
    var destination: [NavigationDestination] = []
    
    /// 화면을 새로 추가 (push)
    func push(to view: NavigationDestination) {
        destination.append(view)
    }
    
    /// 마지막 화면을 제거 (뒤로 가기)
    func pop() {
        _ = destination.popLast()
    }
    
    /// 스택을 초기화하여 Root 화면으로 이동
    func popToRootView() {
        destination.removeAll()
    }
}
