// MARK: - Week 6: 프로퍼티


import Foundation

// MARK: - 프로퍼티 실습
// 1. "사각형의 너비: \(rectangle.width) cm, 높이: \(rectangle.height) cm"와 같이 출력되도록 작성해주세요!
class Rectangle {
    var width: Int
    var height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

var rectangle = Rectangle(width: 10, height: 20)

print("사각형의 너비: \(rectangle.width) cm, 높이: \(rectangle.height) cm")

// 2. "사각형의 면적: \(rectangle.area) cm²"와 같이 출력되도록 작성해주세요!


// 3. "사각형의 면적: \(rectangle.area) \(Rectangle.unit)²" 형식으로 출력되도록 작성해주세요!

