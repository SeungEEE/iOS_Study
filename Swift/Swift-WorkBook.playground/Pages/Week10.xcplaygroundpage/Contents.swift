// MARK: - Week 10: 옵셔널과 옵셔널 언래핑

import Foundation


// MARK: - 옵셔널 실습

// 문제 1: `age`라는 이름의 옵셔널 정수형 변수를 선언한 후 `nil` 값을 할당해주세요. 이후 `25`를 할당하고 `if let`을 사용하여 `age`의 값을 안전하게 출력해주세요.
/// "나이는 25살 입니다."와 같이 출력되도록 작성해주세요!

var age: Int? = nil

age = 25

if let unwrappedAge = age {
    print("나이는 \(unwrappedAge)살 입니다.")
}


// 문제 2: `score`라는 옵셔널 `Double` 변수를 선언하고 `nil`을 할당해주세요. 이후 `78.5`를 할당하고 강제 언래핑을 사용하여 `score`의 값을 출력하세요.
///"점수는 78.5점 입니다."와 같이 출력되도록 작성해주세요!

var score: Double? = nil

score = 78.5

print("점수는 \(score!)점 입니다.")
