//
//  KeyChainManager.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/25/25.
//

import Foundation
import Security

class KeyChainManager: @unchecked Sendable {
    static let standard = KeyChainManager()
    
    // MARK: - KeyChainManagerFunction
    
    /// 토큰 키체인 등록
    /// - Parameters:
    ///   - data: 전달받은 토큰 값
    ///   - key: 토큰 값에 쌍으로 매칭될 키값
    /// - Returns: 저장되었는지 참 거짓으로 반환
    private func save(_ data: Data, for key: String) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked
        ]
        
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil) == noErr
    }
    
    /// 저장된 토큰 값 불러오기
    /// - Parameter key: 토큰 값에 연결될 키값
    /// - Returns: 저장된 값에 대해 Data 타입을 불러옴
    private func load(key: String) -> Data? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == noErr, let data = item as? Data else {
            return nil
        }
        
        return data
    }
    
    /// 저장된 회원정보 삭제
    /// - Parameter key: 지우고자 하는 토큰의 키값 삭제
    private func delete(key: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
    
        SecItemDelete(query as CFDictionary)
    }
    
    // MARK: - Session
    
    /// 세션에 저장된 정보를 저장
    /// - Parameters:
    ///     - sesstion: 유저 정보를 달고 있는 데이터
    ///     - key: 저장할 키 입력
    /// - Returns: 저장완료 참 거짓
    public func saveSesstion(_ session: UserKeyChainInfo, for key: String) -> Bool {
        guard let data = try? JSONEncoder().encode(session) else { return false }
        return save(data, for: key)
    }
    
    /// 세션에 저장된 정보 가져오기
    /// - Parameters key: 저장된 유저 정보 부르고자 하는 키값
    /// - Returns: 키 값으로 저장된 유저 정보 저장
    public func loadSession(for key: String) -> UserKeyChainInfo? {
        guard let data = load(key: key),
              let session = try? JSONDecoder().decode(UserKeyChainInfo.self, from: data) else { return nil }
        return session
    }
    
    /// 유저 정보 삭제
    /// - Parameter key: 삭제하고자 하는 유저
    public func deleteSession(for key: String) {
        delete(key: key)
    }
}
