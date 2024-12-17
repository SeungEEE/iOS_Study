// MARK: - Week 4: 함수와 클로저

import Foundation

// MARK: - 문제 1: 함수 실습

///1. 음식점에서 총 주문 금액과 팁 금액을 입력받고, 팁을 포함한 최종 결제 금액을 계산해 반환하는 함수 `calculateTotalPrice` 를 작성한 뒤 반환된 값을 출력해주세요.
///2. 특정 온도를 입력받아 그에 따라 "덥다", "춥다", "적당하다"라는 메시지를 출력하는 함수 `checkTemperature`를 작성해주세요.
///3. 여행지에 대한 정보(도시 이름, 숙박 일수, 하루 예산)를 입력받아 여행 총 예산을 계산하여 출력하는 함수 `printTravelBudget`을 작성해주세요.
///4. 오늘 날짜를 문자열 형식으로 반환하는 함수 `getCurrentDate`를 작성한 뒤 출력해주세요.
/// -  오늘 날짜를 받아올 수 있는 `Date()` 를 이용해 작성해주세요!

// 1. "최종 결제 금액: (최종 결제 금액)원"과 같이 출력되도록 작성해주세요!
func calculateTotalPrice(orderPrice: Int, tipPrice: Int) -> Int {
    let totalPrice = orderPrice + tipPrice
    return totalPrice
}

let totalPrice = calculateTotalPrice(orderPrice: 10000, tipPrice: 50)
print("최종 결제 금액: \(totalPrice)원")


// 2. "덥다", "춥다", "적당하다"와 같이 출력되도록 작성해주세요!
func checkTemperature(temperature: Int) {
    if temperature >= 30 {
        print("덥다")
    } else if temperature <= 10 {
        print("춥다")
    } else {
        print("적당하다")
    }
}

let currentTemperature = 25
checkTemperature(temperature: currentTemperature)


// 3. "(여행지)에서의 총 여행 예산은 (총 예산)원입니다."와 같이 출력되도록 작성해주세요!
func printTravelBudget(cityName: String, day: Int, dayCost: Int) {
    let totalCost = day * dayCost
    print("\(cityName)에서의 총 여행 예산은 \(totalCost)원입니다.")
}

printTravelBudget(cityName: "서울", day: 3, dayCost: 500000)


// 4. "오늘 날짜: 2024-09-19"와 같이 오늘 날짜가 "YYYY-MM-DD" 형식으로 출력되도록 작성해주세요!
func getCurrentDate() {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let currentDate = formatter.string(from: Date())
    print("오늘 날짜: \(currentDate)")
}

getCurrentDate()


// MARK: - 문제 2: 클로저 실습

/// 1. `Int` 변수를 파라미터로 받아 1부터 파라미터로 받은 변수까지 값을 누적시켜 더한 후 누적 값을 반환하는 `addValue` 클로저를 선언하고 출력해주세요.
/// - 이 때 함수가 아닌 클로저로 선언해주세요!
/// 2. `addValue` 클로저를 선언했다면, 클로저를 `$`를 이용해 경량화한 후 같은 결과를 출력하는지 확인해주세요!

// 1. Int 변수를 파라미터로 받는 addValue 클로저를 선언하고 출력해주세요! 값은 임의로 넣어주세요.
//let addValue: (Int) -> Int = { number in
//    var sum = 0
//    for i in 1...number {
//        sum += i
//    }
//    return sum
//}
//addValue(5)

// 2. 1번에서 선언한 addValue 클로저를 $를 이용해 경량화 시킨 코드를 아래 넣어주세요!

let addValue: (Int) -> Int = {
    var sum = 0
    for i in 1...$0 {
        sum += i
    }
    return sum
}

addValue(5)
