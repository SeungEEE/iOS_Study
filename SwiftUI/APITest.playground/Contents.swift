import SwiftUI

//MARK: POST
//let url = URL(string: "http://localhost:8080/person")!
//var request = URLRequest(url: url)
//request.httpMethod = "POST"
//
//let parameters: [String: Any] = [
//      "name": "이안",
//      "age": 25,
//      "address": "포항시 효곡동",
//      "height": 171
//]
//
//request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//
//task.resume()

//MARK: GET
//var urlComponents = URLComponents(string: "http://localhost:8080/person")!
//urlComponents.queryItems = [
//    URLQueryItem(name: "name", value: "제옹")
//]
//
//let url = urlComponents.url!
//
//let task = URLSession.shared.dataTask(with: url) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//task.resume()

//MARK: PATCH
//let url = URL(string: "http://localhost:8080/person")!
//var request = URLRequest(url: url)
//request.httpMethod = "PATCH"
//
//let parameters: [String: Any] = [
//    "name": "Je-Ong",
//]
//request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//task.resume()

//MARK: PUT
//let url = URL(string: "http://localhost:8080/person")!
//var request = URLRequest(url: url)
//request.httpMethod = "PATCH"
//
//// 요청 본문에 전송할 데이터
//let parameters: [String: Any] = [
//    "name": "Je-Ong",
//]
//request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//task.resume()

//MARK: DELETE
//var urlComponents = URLComponents(string: "http://localhost:8080/person")!
//urlComponents.queryItems = [
//    URLQueryItem(name: "name", value: "제옹")
//]
//
//let url = urlComponents.url!
//var request = URLRequest(url: url)
//request.httpMethod = "DELETE"
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("Status Code: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("Response Data: \(responseString!)")
//    }
//}
//task.resume()

//MARK: Actor 이용한 GET Method

struct Person: Codable {
    let name: String
    let age: Int
    let address: String
    let height: Double
}

actor NetworkManager {
    /// GET
    func getUserData() async throws -> String {
        var urlComponents = URLComponents(string: "http://localhost:8080/person")!
        urlComponents.queryItems = [
            URLQueryItem(name: "name", value: "이안")
        ]
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        guard let responseString = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        return responseString
    }
    
    // POST 메서드
    func postUserData(user: Person) async throws -> String {
        guard let url = URL(string: "http://localhost:8080/person") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try JSONEncoder().encode(user)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        guard let responseString = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        return responseString
    }
    
    // DELETE 메서드
    func deleteUserData(name: String) async throws -> String {
        var urlComponents = URLComponents(string: "http://localhost:8080/person")!
        urlComponents.queryItems = [
            URLQueryItem(name: "name", value: name)
        ]
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        guard let responseString = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        return responseString
    }
    
}

let networkManager = NetworkManager()

Task {
    do {
        // GET 요청
        let result = try await networkManager.getUserData()
        print("응답 데이터:", result)
        
        // POST 요청
        let newUser = Person(name: "이안", age: 30, address: "서울", height: 175.0)
        let postResult = try await networkManager.postUserData(user: newUser)
        print("POST 응답 데이터:", postResult)
        
        // DELETE 요청
        let deleteResult = try await networkManager.deleteUserData(name: "이안")
        print("DELETE 응답 데이터:", deleteResult)
    } catch {
        print("네트워크 에러", error)
    }
}
