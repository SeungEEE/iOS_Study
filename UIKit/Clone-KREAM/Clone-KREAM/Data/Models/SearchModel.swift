//
//  SearchModel.swift
//  Clone-KREAM
//
//  Created by 이승진 on 2/11/25.
//

import Foundation

struct SearchModel {
    
    /// 검색어 목록을 저장할 때 사용할 고유한 키
    private let recentSearchWordKey = "recentSearchWordKey"
    
    
    /// 최근 검색어 불러오기
    func loadRecentSearchWord() -> [String] {
        return UserDefaults.standard.stringArray(forKey: recentSearchWordKey) ?? []
    }
    
    
    /// 검색어 저장하기
    func saveSearchQuery(_ query: String) -> [String] {
        var recentSearches = loadRecentSearchWord()
        
        recentSearches.removeAll() { $0 == query } // 중복제거
        recentSearches.insert(query, at: 0) // 가장 앞에 추가
        
        if recentSearches.count > 10 {
            recentSearches.removeLast() // 최대 10개까지 저장
        }
        
        UserDefaults.standard.set(recentSearches, forKey: recentSearchWordKey)
        return recentSearches
    }
    
    
    /// 검색 기록 삭제
    func clearRecentSearches() {
        UserDefaults.standard.removeObject(forKey: recentSearchWordKey)
    }
}
