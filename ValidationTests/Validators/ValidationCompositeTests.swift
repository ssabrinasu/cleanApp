//
//  ValidationCompositeTests.swift
//  ValidationTests
//
//  Created by Sabrina on 06/10/21.
//

import XCTest
import Validation

class ValidationComposite: Validation {
    func validate(data: [String : Any]?) -> String? {
        let validations: [Validation]
        
        init(validations: [Validation]) {
            self.validations: validations
        }
        
        func validate(data: [String : Any]?) -> String? {
            
        }
    }
}

class ValidationCompositeTests: XCTestCase {
    func est_validate_should_return_error_if_validation_fails() {
        let validationSpy = ValidationSpy()
        let sut = ValidationComposite(validations: [validationSpy])
        let errorMessage = sut.validate(data: ["name": "Rodrigo"])
        XCTAssertEqual(errorMessage, <#T##expression2: Equatable##Equatable#>)
    }
}

class ValidationSpy: Validation {
    func validate(data: [String : Any]?) -> String? {
        
    }
}
