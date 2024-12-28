// MARK: - Week 5: 클래스, 구조체, Actor

import Foundation

// MARK: - 문제 1. 은행 계좌 관리 시스템 - Class 구현
class BankAccount {
    let accountNumber: String // 계좌번호
    private(set) var balance: Double // 현재 잔액
    
    init(accountNumber: String, initialBalance: Double) {
        self.accountNumber = accountNumber
        self.balance = max(0, initialBalance) // 초기 잔액이 음수면 0으로 설정
    }
    
    /// 입금 메서드
    func deposit(amount: Double) {
        guard amount > 0 else {
            print("Invalid deposit amount.")
            return
        }
        balance += amount
        print("Deposited: \(amount). Current balance: \(balance)")
    }
    
    /// 출금 메서드
    func withdraw(amount: Double) {
        guard amount > 0 else {
            print("Invalid withdrawal amount.")
            return
        }
        if amount > balance {
            print("Insufficient funds. Current balance: \(balance)")
        } else {
            balance -= amount
            print("Withdrew: \(amount). Current balance: \(balance)")
        }
    }
}

let account = BankAccount(accountNumber: "123-456", initialBalance: 100.0)

account.deposit(amount: 50.0) // 출력: "Deposited 50.0. Current balance: 150.0"
account.withdraw(amount: 30.0) // 출력: "Withdrew 30.0. Current balance: 120.0"
account.withdraw(amount: 200.0) // 출력: "Insufficient funds. Current balance: 120.0"

// MARK: - 문제 2. 차량 관리 시스템 - Struct 구현
struct Car {
    var make: String // 제조사
    var model: String // 차량 모델
    var year: Int // 차량 연식
    var mileage: Double // 현재 주행거리
    var isRunning: Bool // 차량 상태
    
    init(make: String, model: String, year: Int, mileage: Double, isRunning: Bool) {
        self.make = make
        self.model = model
        self.year = year
        self.mileage = mileage
        self.isRunning = isRunning
    }
    
    mutating func start() {
        if isRunning {
            print("차 이미 시동 중.")
        } else {
            isRunning = true
            print("차 시동 걸림.")
        }
    }
    
    mutating func stop() {
        if !isRunning {
            print("차 이미 꺼짐.")
        } else {
            isRunning = false
            print("차 시동 꺼짐.")
        }
    }
    
    mutating func drive(distance: Double) {
        if isRunning {
            mileage += distance
            print("이동거리 \(Int(distance)) km. 현재 mileage: \(Int(mileage)) km")
        } else {
            print("이동 불가능. 차 시동 꺼짐.")
        }
    }
}

var myCar = Car(make: "한국", model: "KIA", year: 2024, mileage: 15000.0, isRunning: false)

myCar.start() // 출력: "차 시동 걸림."
myCar.drive(distance: 100) // 출력: "이동거리 100 km. 현재 mileage: 15100 km"
myCar.stop() // 출력: "차 시동 꺼짐."
myCar.drive(distance: 50) // 출력: "이동 불가능. 차 시동 꺼짐."
myCar.start() // 출력: "Car started."
myCar.start() // 출력: "차 이미 시동 중."

// MARK: - 비동기 주문 처리 시스템
actor OrderProcessor {
    private var orders: [String] = []
    
    // 주문 추가 메서드
    func addOrder(_ order: String) {
        orders.append(order)
        print("추가된 주문: \(order)")
    }
    
    // 주문 처리 메서드
    func processOrder() {
        if orders.isEmpty {
            print("처리할 주문 없음")
        } else {
            let order = orders.removeFirst()
            print("처리된 주문: \(order)")
        }
    }
    
    // 현재 남아있는 주문 출력 메서드
    func printAllOrder() {
        if orders.isEmpty {
            print("남아 있는 주문 없음")
        } else {
            print("남아 있는 주문: \(orders.joined(separator: ", "))")
        }
    }
}

let orderProcessor = OrderProcessor()

Task {
    await orderProcessor.addOrder("Pizza")
    await orderProcessor.addOrder("Buger")
    await orderProcessor.addOrder("Pasta")
    
    await orderProcessor.processOrder()
    await orderProcessor.processOrder()
    
    await orderProcessor.printAllOrder()
    
    await orderProcessor.processOrder()
    
    await orderProcessor.processOrder()
    
    await orderProcessor.printAllOrder()
}
