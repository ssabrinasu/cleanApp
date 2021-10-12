//
//  ValidationSpy.swift
//  PresentationTests
//
//  Created by Sabrina on 05/10/21.
//

import Foundation
import Presentation

class ValidationSpy: Validation {
    var data: [String: Any]?
    var errorMessage: String?
    
    func validate(data: [String: Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
    func simulateError() {
        self.errorMessage = "Error"
    }
}
