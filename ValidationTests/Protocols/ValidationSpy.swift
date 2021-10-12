//
//  ValidationSpy.swift
//  ValidationTests
//
//  Created by Sabrina on 07/10/21.
//

import Foundation
import Presentation
import Validation

class ValidationSpy: Validation {
    var errorMessage: String?
    var data: [String: Any]?
    
    func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
    func simulatError(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
}
