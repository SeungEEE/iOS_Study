// MARK: - Week 8: 상속


import Foundation

// MARK: - 상속 실습
// 1. "동물이 소리를 냅니다."와 같이 출력되도록 작성해주세요!
class Animal {
    func makeSound() {
        print("동물이 소리를 냅니다.")
    }
}

let animal = Animal()
animal.makeSound()

// 2. "멍멍!"과 같이 출력되도록 작성해주세요!
class Dog: Animal {
    override func makeSound() {
        print("멍멍!")
    }
}

let dog = Dog()
dog.makeSound()

// 3. "쿽쿽!"과 같이 출력되도록 작성해주세요!

class Quokka: Animal {
    override func makeSound() {
        print("쿽쿽!")
    }
}

let quokka = Quokka()
quokka.makeSound()
