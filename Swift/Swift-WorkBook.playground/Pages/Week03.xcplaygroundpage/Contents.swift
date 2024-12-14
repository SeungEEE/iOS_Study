// MARK: - Week 3: 딕셔너리와 세트, 열거형

import Foundation

// MARK: - 문제 1: 딕셔너리 실습
///학생들의 이름과 그들의 점수를 관리하는 프로그램 작성
///1 . 학생들의 이름(Alice, Bob, Min)을 키로, 점수를 값으로 가지는 딕셔너리를 선언하세요
/// 2. 학생 “Alice”의 점수를 95점으로 수정하세요
/// 3. “Bob”의 점수를 삭제하고, 남은 학생들의 점수를 출력하세요

// 1. 학생들의 점수 딕셔너리 선언
var studentScore: [String : Int] = ["Alice" : 0, "Bob" : 0, "Min" : 0]

// 2. “Alice”의 점수를 95점으로 수정
studentScore["Alice"] = 95

// 3. “Bob”의 점수를 삭제하고, 남은 학생들의 점수를 출력
studentScore["Bob"] = nil

for (name, score) in studentScore {
    print("\(name)의 점수 \(score)")
}

// MARK: - 문제 2: Set 실습
/// Set를 사용하여 중복되지 않는 과일 목록을 관리하는 프로그램 작성
/// 1. Set를 사용하여 “Apple”, “Banana”, “Orange”를 추가하는 과일 목록을 선언
/// 2. “Banana”가 이미 존재하는지 확인하고, 존재하면 “Mango”를 추가하세요
/// 3. 세트에 있는 모든 과일을 반복문으로 출력하세요

// 1. 과일 목록 세트 선언
var fruits : Set<String> = ["Apple", "Banana", "Orange"]

// 2. “Banana”가 이미 존재하는지 확인하고, 존재하면 “Mango”를 추가하세요
if fruits.contains("Banana") {
    fruits.insert("Mango")
}

// 3. 세트에 있는 모든 과일을 반복문으로 출력하세요
for fruit in fruits {
    print(fruit)
}

// MARK: - 문제 3: Enum 실습
// 1. 네트워크 요청 상태 열거형 정의
enum NetworkState {
    case idle
    case requesting
    case success(String)
    case failure(String)
}

// 2. 네트워크 요청 상태를 나타내는 변수 선언
var currentState : NetworkState = .success("데이터 로드 완료")

// 3. switch문으로 상태에 맞는 출력 작성
switch currentState {
case .idle:
    print("현재 대기 상태입니다.")
case .requesting:
    print("요청 중입니다...")
case .success(let success):
    print("요청 성공: \(success)")
case .failure(let error):
    print("요청 실패: \(error)")
}

