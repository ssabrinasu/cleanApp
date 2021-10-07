//
//  CompareFieldsValidationTests.swift
//  ValidationTests
//
//  Created by Sabrina on 06/10/21.
//

import XCTest
import Presentation
import Validation

class CompareFieldsValidationTests: XCTestCase {
    func test_validate_should_return_error_if_field_is_not_provided() {
        let sut = makeSut(fieldName: "password", fieldLabel: "Senha", fieldNameToCompare: "passwordConfirmation")
        let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "1234"])
        XCTAssertEqual(errorMessage, "O campo Senha e invalido")
        
    }
    
    func test_validate_should_return_error_if_with_correct_fieldLabel() {
        let sut = makeSut(fieldName: "password", fieldLabel: "Confirmar Senha", fieldNameToCompare: "passwordConfirmation")
        let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "1234"])
        XCTAssertEqual(errorMessage, "O campo Confirmar Senha e invalido")
        
    }
    
    func test_validate_should_return_nil_if_field_is_provided() {
        let sut = makeSut(fieldName: "password", fieldLabel: "Senha", fieldNameToCompare: "passwordConfirmation")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo Senha e invalido")
    }
    
    func test_validate_should_return_nil_if_no_data_is_provided() {
        let sut = makeSut(fieldName: "password", fieldLabel: "Senha", fieldNameToCompare: "passwordConfirmation")
        let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "123"])
        XCTAssertNil(errorMessage)
    }
}

extension CompareFieldsValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, fieldNameToCompare: String, file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = CompareFieldsValidation(fieldName: fieldName, fieldLabel: fieldLabel, fieldNameToCompare: fieldNameToCompare)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}


