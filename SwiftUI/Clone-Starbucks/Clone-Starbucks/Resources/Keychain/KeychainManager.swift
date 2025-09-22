//
//  KeychainManager.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 9/22/25.
//

import Foundation
import Security

/// 키체인에 사용자 정보를 저장하고 로드하는 기능을 담당하는 싱글톤 클래스
final class KeychainManager: @unchecked Sendable {
  
  /// 전역에서 사용할 수 있는 KeychainManager 인스턴스
  static let standard = KeychainManager()
  
  /// 외부에서 초기화하지 못하도록 private 생성자 사용
  private init() {}
  
  // MARK: - Function
  
  /// 데이터를 키체인에 저장하는 함수
  @discardableResult
  private func save(_ data: Data, for key: String) -> Bool {
    // 기존에 같은 키가 있으면 먼저 삭제
    if load(key: key) != nil {
      _ = delete(key: key)
    }
    
    // 키체인 저장 쿼리 구성
    let query: [CFString: Any] = [
      
      // 일반 비밀번호 항목
      kSecClass: kSecClassGenericPassword,
      
      // 키 값
      kSecAttrAccount: key,
      
      // 저장할 데이터
      kSecValueData: data,
      
      // 기기 잠금 해제 시에만 접근 가능
      kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked
    ]
    
    // 키체인에 데이터 저장
    let status = SecItemAdd(query as CFDictionary, nil)
    if status != errSecSuccess {
      print("키체인 저장 실패: \(status) - \(SecCopyErrorMessageString(status, nil) ?? "알 수 없는 오류" as CFString)")
    }
    
    return status == errSecSuccess
  }
  
  /// 키체인에서 데이터를 로드하는 함수
  private func load(key: String) -> Data? {
    // 키체인 조회 쿼리 구성
    let query: [CFString: Any] = [
      // 일반 비밀번호 항목
      kSecClass: kSecClassGenericPassword,
      
      // 키 값
      kSecAttrAccount: key,
      
      // 데이터를 반환하도록 설정
      kSecReturnData: kCFBooleanTrue!,
      
      // 첫 번째 결과만 반환
      kSecMatchLimit: kSecMatchLimitOne
    ]
    
    var item: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &item)
    
    if status != errSecSuccess {
      print("키체인 로드 실패: \(status) - \(SecCopyErrorMessageString(status, nil) ?? "알 수 없는 에러" as CFString)")
    }
    
    return item as? Data
  }
  
  /// 키체인에서 데이터를 삭제하는 함수
  @discardableResult
  private func delete(key: String) -> Bool {
    
    // 키체인 삭제 쿼리 구성
    let query: [CFString: Any] = [
      // 일반 비밀번호 항목
      kSecClass: kSecClassGenericPassword,
      
      // 키 값
      kSecAttrAccount: key
    ]
    
    let status = SecItemDelete(query as CFDictionary)
    if status != errSecSuccess && status != errSecItemNotFound {
      print("키 체인 삭제 실패: \(status) - \(SecCopyErrorMessageString(status, nil) ?? "Unknown error" as CFString)")
    }
    
    return status == errSecSuccess
  }
  
  // MARK: - 사용자 정의 메서드 (UserKeychain 객체용)
  
  /// UserKeychain 객체를 키체인에 저장
  public func saveSession(_ session: UserKeychain, for key: String) -> Bool {
    guard let data = try? JSONEncoder().encode(session) else { return false }
    return save(data, for: key)
  }
  
  /// 키체인에서 UserKeychain 객체를 불러오기
  public func loadSession(for key: String) -> UserKeychain? {
    guard let data = load(key: key),
          let session = try? JSONDecoder().decode(UserKeychain.self, from: data) else { return nil }
    return session
  }
  
  /// 키체인에서 UserKeychain 객체 삭제
  public func deleteSession(for key: String) {
    _ = delete(key: key)
  }
}
