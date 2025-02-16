//
//  SearchManager.swift
//  Clone-KREAM
//
//  Created by 이승진 on 2/10/25.
//

import Foundation
import Moya

class SearchManager {
    private let provider = MoyaProvider<SearchRouter>()
    
    /// 검색 텍스트 필드에 넣은 값 API로 결과 받아오기
    /// - Parameter :
    ///     - query: 검색하고자 하는 값, 텍스트 필드에 넣은 값을 쿼리로 사용
    ///     - completion: 성공과 실패에 따른 값 반환
    func fetchSearchResults(query: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        provider.request(.search(query: query)) { result in
            switch result {
            case .success(let response):
                do {
                    let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: response.data)
                    completion(.success(searchResponse))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
