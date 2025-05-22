//
//  ContentViewModel.swift
//  TestMoya
//
//  Created by 이승진 on 5/22/25.
//

import Foundation
import Moya

@Observable
class ContentViewModel {
    var userData: UserData?
    let provider: MoyaProvider<UserRouter>
    var patchData: UserPatchRequest?
    
    init() {
        let logger = NetworkLoggerPlugin(configuration: .init(logOptions: [.verbose]))
        self.provider = MoyaProvider<UserRouter>(plugins: [logger])
    }
    
    func getUserData(name: String) {
        provider.request(.getPerson(name: name), completion: { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(UserData.self, from: response.data)
                    self?.userData = decodedData
                } catch {
                    print("유저 데이터 디코더 오류", error)
                }
            case .failure(let error):
                print("error", error)
            }
        })
    }
    
    func createUser(_ userData: UserData) {
        provider.request(.postPerson(userData: userData)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(UserData.self, from: response.data)
                    self?.userData = decodedData
                } catch {
                    print("유저 데이터 디코더 오류", error)
                }
            case .failure(let error):
                print("error", error)
            }
            
//            switch result {
//            case .success(let response):
//                print("POST 성공: \(response.statusCode)")
//            case .failure(let error):
//                print("error", error)
//            }
        }
    }
    
    func updateUserPatch(_ patchData: UserPatchRequest) {
        provider.request(.patchPerson(patchData: patchData)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(UserData.self, from: response.data)
                    self?.userData = decodedData
                } catch {
                    print("유저 데이터 디코더 오류", error)
                }
            case .failure(let error):
                print("error", error)
            }
            
//            
//            switch result {
//            case .success(let response):
//                print("PATCH 성공: \(response.statusCode)")
//            case .failure(let error):
//                print("error", error)
//            }
        }
    }
    
    func updateUserPut(_ userData: UserData) {
        provider.request(.putPerson(userData: userData)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(UserData.self, from: response.data)
                    self?.userData = decodedData
                } catch {
                    print("유저 데이터 디코더 오류", error)
                }
            case .failure(let error):
                print("error", error)
            }
            
//            switch result {
//            case .success(let response):
//                print("PUT 성공: \(response.statusCode)")
//            case .failure(let error):
//                print("error", error)
//            }
        }
    }
    
    func deleteUser(name: String) {
        provider.request(.deletePerson(name: name)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(UserData.self, from: response.data)
                    self?.userData = decodedData
                } catch {
                    print("유저 데이터 디코더 오류", error)
                }
            case .failure(let error):
                print("error", error)
            }
            
//            switch result {
//            case .success(let response):
//                print("DELETE 성공: \(response.statusCode)")
//            case .failure(let error):
//                print("error", error)
//            }
        }
    }
}
