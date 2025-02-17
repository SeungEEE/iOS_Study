// MARK: - Week 9: 프로토콜과 익스텐션

import Foundation


// MARK: - 문제 1: 익스텐션으로 메서드 추가하기
/// Int 타입에 익스텐션을 사용하여 square 메서드를 추가하려고 합니다. 빈칸을  채워 코드를 완성해주세요

extension Int {
    func square() -> Int {
        return self * self
    }
}

let number = 4

print(number.square()) // 출력 : 16
      
      
// MARK: - 문제 2: 프로토콜과 프로토콜 익스텐션
/// 프로토콜을 구현하고 프토토콜 익스텐션을 하여 코드가 작동되도록 작성해주세요

protocol TestB {
    func methodA() -> String
}

extension TestB {
    func methodA() -> String {
        return "안녕허세요!! 문법 문제입니다!!"
    }
}
      
struct Item: TestB {}
      
let item = Item()
print(item.methodA()) // 출력 : 안녕허세요!! 문법 문제입니다!!


// MARK: - 문제 3: 프로토콜에 추가 메서드 구현하기
/// 프로토콜을 구현해주세요! 그 후, 익스텐션 부분의 빈칸을 완성해주세요!
      
protocol Summable {
    var value: Int { get }
    func sum(with other: Self) -> Int
}
      
extension Summable {
    func sum(with other: Self) -> Int {
        return self.value + other.value
    }
}
      
struct Number: Summable {
    var value: Int
}
      
let number1 = Number(value: 3)
let number2 = Number(value: 5)
      
print(number1.sum(with: number2)) // 출력 : 8
