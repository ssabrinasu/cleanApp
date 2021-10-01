//
//  EmailValidatorAdapterTests.swift
//  ValidationTests
//
//  Created by Sabrina on 30/09/21.
//

import XCTest
import Validation
import Presentation

class EmailValidatorAdapterTests: XCTestCase {

    func test_invalid_emails() {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "aa"))
        XCTAssertFalse(sut.isValid(email: "aa@"))
        XCTAssertFalse(sut.isValid(email: "aa@aa"))
        XCTAssertFalse(sut.isValid(email: "aa@aa."))
        XCTAssertFalse(sut.isValid(email: "@aaa.com"))
    }
    
    func test_valid_emails() {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "aaaaa@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "bbbbb@hotmail.com"))
        XCTAssertTrue(sut.isValid(email: "bbbbb@hotmail.com.br"))
    }
}

extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter {
        return EmailValidatorAdapter()
    }
}
