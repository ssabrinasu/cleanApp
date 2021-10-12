//
//  ValidationCompositeTests.swift
//  ValidationTests
//
//  Created by Sabrina on 06/10/21.
//

import XCTest
import Presentation
import Validation

class ValidationCompositeTests: XCTestCase {
    func test_validate_should_return_error_if_validation_fails() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        validationSpy.simulatError("Erro 1")
        let errorMessage = sut.validate(data: ["name": "Rodrigo"])
        XCTAssertEqual(errorMessage, "Erro 1")
    }
    
    func test_validate_should_return_correct_error_message() {
        let validationSpy = ValidationSpy()
        let validationSpy2 = ValidationSpy()
        let sut = makeSut(validations: [validationSpy, validationSpy2])
        validationSpy2.simulatError("Erro 2")
        let errorMessage = sut.validate(data: ["name": "Rodrigo"])
        XCTAssertEqual(errorMessage, "Erro 2")
    }
    
    func test_validate_should_return_the_first_error_message() {
        let validationSpy2 = ValidationSpy()
        let validationSpy3 = ValidationSpy()
        let sut = makeSut(validations: [ValidationSpy(), validationSpy2, validationSpy3])
        validationSpy2.simulatError("Erro 2")
        validationSpy3.simulatError("Erro 3")
        let errorMessage = sut.validate(data: ["name": "Rodrigo"])
        XCTAssertEqual(errorMessage, "Erro 2")
    }
    
    func test_validate_should_return_nil_if_validation_succeeds() {
        let sut = makeSut(validations: [ValidationSpy(), ValidationSpy()])
        let errorMessage = sut.validate(data: ["name": "Rodrigo"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_call_validation_with_correct_data() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        let data = ["name": "Rodrigo"]
        let _ = sut.validate(data: data)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: data))
    }
}

extension ValidationCompositeTests {
    func makeSut(validations: [ValidationSpy], file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = ValidationComposite(validations: validations)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
