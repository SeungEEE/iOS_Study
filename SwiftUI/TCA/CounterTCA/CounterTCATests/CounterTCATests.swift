//
//  CounterTCATests.swift
//  CounterTCATests
//
//  Created by 이승진 on 2/24/25.
//

import ComposableArchitecture
import XCTest
@testable import CounterTCA

@MainActor
final class CounterTCATests: XCTestCase {
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
    }
    
    func testTimer() async throws {
        let clock = TestClock()
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerOn = true
        }
        
        await clock.advance(by: .seconds(1))
        await store.receive(.timerTicked) {
            $0.count = 1
        }
        
        await clock.advance(by: .seconds(1))
        await store.receive(.timerTicked) {
            $0.count = 2
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerOn = false
        }
    }
    
    func testGetFact() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = { "\($0) is a great number!"}
        }
        
        await store.send(.getFactButtonTapped) {
            $0.isLoadingFact = true
        }
        
        await store.receive(.factResponse(" 0 is a great number!")) {
            $0.fact = "0 is a great number!"
            $0.isLoadingFact = false
        }
    }
    
    func testGetFact_Failure() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = { _ in
                struct SomeError: Error {}
                throw SomeError()
            }
        }
        XCTExpectFailure()
        await store.send(.getFactButtonTapped) {
            $0.isLoadingFact = true
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
