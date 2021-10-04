//
//  SignUpIntegrationTests.swift
//  MainTests
//
//  Created by Sabrina on 01/10/21.
//

import XCTest
import Main

class SignUpIntegrationTests: XCTestCase {
    func testExample() {
        debugPrint("===============================")
        debugPrint(Environment.variable(.apiBaseUrl))
        debugPrint("===============================")
        let sut = SignUpComposers.composeControllerWith(addAccount: AddAccountSpy())
        checkMemoryLeak(for: sut)
    }
}
