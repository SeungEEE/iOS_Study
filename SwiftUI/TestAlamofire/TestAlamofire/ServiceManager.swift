//
//  ServiceManager.swift
//  TestAlamofire
//
//  Created by 이승진 on 5/15/25.
//

import Foundation
import Alamofire

final class ServiceManager {
    
    static let shared = ServiceManager()
    
    private let session: Session
    private let urlString: String = "\(Config.baseURL)/person"
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        
        self.session = Session(configuration: configuration)
    }
    
    // MARK: - GET 요청
    func getUser(name: String) async {
        let parameters: [String: String] = [
            "name": name
        ]
        
        do {
            let user = try await session.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default)
                .serializingDecodable(UserDTO.self)
                .value
            print("GET 성공:", user)
        } catch {
            print("GET 실패:", error.localizedDescription)
        }
    }
    
    // MARK: - POST 요청
    func postUser(user: UserDTO) async {
        do {
            let response = try await session.request(urlString, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
                .serializingString()
                .value
            print("POST 성공:", response)
        } catch {
            print("POST 실패:", error.localizedDescription)
        }
    }
    
    // MARK: - PUT 요청
    func putUser(user: UserDTO) async {
        do {
            let response = try await session.request(urlString, method: .put, parameters: user, encoder: JSONParameterEncoder.default)
                .serializingString()
                .value
            print("PUT 성공:", response)
        } catch {
            print("PUT 실패:", error.localizedDescription)
        }
    }
    
    // MARK: - PATCH 요청
    func patchUser(name: String) async {
        let parameters: [String: String] = [
            "name": name
        ]
        
        do {
            let response = try await session.request(urlString, method: .patch, parameters: parameters, encoding: JSONEncoding.default)
                .serializingString()
                .value
            print("PATCH 성공:", response)
        } catch {
            print("PATCH 실패:", error.localizedDescription)
        }
    }
    
    // MARK: - DELETE 요청
    func deleteUser(name: String) async {
        let parameters: [String: String] = [
            "name": name
        ]
        
        do {
            let response = try await session.request(urlString, method: .delete, parameters: parameters, encoding: URLEncoding.default)
                .serializingString()
                .value
            print("DELETE 성공:", response)
        } catch {
            print("DELETE 실패:", error.localizedDescription)
        }
    }
}

    /// global
    // MARK: - GET 요청
    //    func getUser(name: String) {
    //        let parameter: [String: String] = [
    //            "name": name
    //        ]
    //
    //        AF.request(urlString, method: .get, parameters: parameter, encoding: URLEncoding.default)
    //            .validate()
    //            .responseDecodable(of: UserDTO.self, queue: .global(), completionHandler: { response in
    //                switch response.result {
    //                case .success(let user):
    //                    print("GET 성공", user)
    //                case .failure(let error):
    //                    print("GET 에러", error)
    //                }
    //            })
    //    }
    //
    //    // MARK: - POST 요청
    //    func postUser(user: UserDTO) {
    //        AF.request(urlString, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
    //            .validate()
    //            .responseDecodable(of: String.self, queue: .global(), completionHandler: { response in
    //                switch response.result {
    //                case .success(let success):
    //                    print("POST 성공:", success)
    //                case .failure(let error):
    //                    print("POST 에러:", error.localizedDescription)
    //                }
    //            })
    //    }
    //
    //    // MARK: - PATCH 요청
    //    func patchUser(name: String) {
    //        let parameter: [String: String] = [
    //            "name": name
    //        ]
    //
    //        AF.request(urlString, method: .patch, parameters: parameter, encoding: JSONEncoding.default)
    //            .validate()
    //            .responseDecodable(of: String.self, queue: .global(), completionHandler: { response in
    //                switch response.result {
    //                case .success(let user):
    //                    print("PATCH 성공: \(user)")
    //                case .failure(let error):
    //                    print("PATCH 실패: \(error.localizedDescription)")
    //                }
    //            })
    //    }
    //
    //    // MARK: - DELETE 요청
    //    func deleteUser(name: String) {
    //        let parameter: [String: String] = [
    //            "name": name
    //        ]
    //
    //        AF.request(urlString, method: .delete, parameters: parameter, encoding: URLEncoding.default)
    //            .validate()
    //            .responseDecodable(of: String.self, queue: .global(), completionHandler: { response in
    //                switch response.result {
    //                case .success(let user):
    //                    print("PUT 성공: \(user)")
    //                case .failure(let error):
    //                    print("PUT 실패: \(error.localizedDescription)")
    //                }
    //            })
    //    }
    
    /// Custom Queue
//    private let networkQueue = DispatchQueue(label: "com.testAlamofire.network", qos: .userInitiated)
//    
//    // MARK: - GET 요청
//    
//    func getUser(name: String) {
//        let parameter: [String: String] = [
//            "name": name
//        ]
//        
//        AF.request(urlString, method: .get, parameters: parameter, encoding: URLEncoding.default)
//            .validate()
//            .responseDecodable(of: UserDTO.self, queue: networkQueue, completionHandler: { response in
//                switch response.result {
//                case .success(let user):
//                    print("GET 성공:", user)
//                case .failure(let error):
//                    print("GET 에러:", error)
//                }
//            })
//    }
//    
//    // MARK: - POST 요청
//    
//    func postUser(user: UserDTO) {
//        AF.request(urlString, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
//            .validate()
//            .responseDecodable(of: String.self, queue: networkQueue, completionHandler: { response in
//                switch response.result {
//                case .success(let success):
//                    print("POST 성공:", success)
//                case .failure(let error):
//                    print("POST 에러:", error.localizedDescription)
//                }
//            })
//    }
//    
//    // MARK: - PUT 요청
//    
//    func putUser(user: UserDTO) {
//        AF.request(urlString, method: .put, parameters: user, encoder: JSONParameterEncoder.default)
//            .validate()
//            .responseDecodable(of: String.self, queue: networkQueue, completionHandler: { response in
//                switch response.result {
//                case .success(let user):
//                    print("PUT 성공: \(user)")
//                case .failure(let error):
//                    print("PUT 실패: \(error.localizedDescription)")
//                }
//            })
//    }
//    
//    // MARK: - PATCH 요청
//    
//    func patchUser(name: String) {
//        
//        let parameter: [String: String] = [
//            "name": name
//        ]
//        
//        AF.request(urlString, method: .patch, parameters: parameter, encoding: JSONEncoding.default)
//            .validate()
//            .responseDecodable(of: String.self, queue: networkQueue, completionHandler: { response in
//                switch response.result {
//                case .success(let user):
//                    print("PATCH 성공: \(user)")
//                case .failure(let error):
//                    print("PATCH 실패: \(error.localizedDescription)")
//                }
//            })
//    }
//    
//    // MARK: - DELETE 요청
//    
//    func deleteUser(name: String) {
//        
//        let parameter: [String: String] = [
//            "name": name
//        ]
//        
//        AF.request(urlString, method: .delete, parameters: parameter, encoding: URLEncoding.default)
//            .validate()
//            .responseDecodable(of: String.self, queue: networkQueue, completionHandler: { response in
//                switch response.result {
//                case .success(let user):
//                    print("PUT 성공: \(user)")
//                case .failure(let error):
//                    print("PUT 실패: \(error.localizedDescription)")
//                }
//            })
//    }
    
    
    /// Async / Await
    // MARK: - GET 요청
//    func getUser(name: String) async {
//        let parameters: [String: String] = [
//            "name": name
//        ]
//        
//        do {
//            let user = try await AF.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default)
//                .serializingDecodable(UserDTO.self)
//                .value
//            print("GET 성공:", user)
//        } catch {
//            print("GET 실패:", error.localizedDescription)
//        }
//    }
//    
//    // MARK: - POST 요청
//    func postUser(user: UserDTO) async {
//        do {
//            let response = try await AF.request(urlString, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
//                .serializingString()
//                .value
//            print("POST 성공:", response)
//        } catch {
//            print("POST 실패:", error.localizedDescription)
//        }
//    }
//    
//    // MARK: - PUT 요청
//    func putUser(user: UserDTO) async {
//        do {
//            let response = try await AF.request(urlString, method: .put, parameters: user, encoder: JSONParameterEncoder.default)
//                .serializingString()
//                .value
//            print("PUT 성공:", response)
//        } catch {
//            print("PUT 실패:", error.localizedDescription)
//        }
//    }
//    
//    // MARK: - PATCH 요청
//    func patchUser(name: String) async {
//        let parameters: [String: String] = [
//            "name": name
//        ]
//        
//        do {
//            let response = try await AF.request(urlString, method: .patch, parameters: parameters, encoding: JSONEncoding.default)
//                .serializingString()
//                .value
//            print("PATCH 성공:", response)
//        } catch {
//            print("PATCH 실패:", error.localizedDescription)
//        }
//    }
//    
//    // MARK: - DELETE 요청
//    func deleteUser(name: String) async {
//        let parameters: [String: String] = [
//            "name": name
//        ]
//        
//        do {
//            let response = try await AF.request(urlString, method: .delete, parameters: parameters, encoding: URLEncoding.default)
//                .serializingString()
//                .value
//            print("DELETE 성공:", response)
//        } catch {
//            print("DELETE 실패:", error.localizedDescription)
//        }
//    }
