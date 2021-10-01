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
        let sut = SignUpComposers.composeControllerWith(addAccount: AddAccountSpy())
        checkMemoryLeak(for: sut)
    }
}
