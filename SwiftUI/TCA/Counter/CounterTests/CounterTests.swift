//
//  CounterTests.swift
//  CounterTests
//
//  Created by 이승진 on 10/2/24.
//

import ComposableArchitecture
@testable import Counter
import XCTest

@MainActor
final class CounterTests: XCTestCase {
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
    }
    
    func testTimer() async {
        let store = TestStore(
            initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0
        }
    }

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}
