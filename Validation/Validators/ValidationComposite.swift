//
//  ValidationComposite.swift
//  Validation
//
//  Created by Sabrina on 07/10/21.
//

import Foundation
import Presentation

public final class ValidationComposite: Validation {
    let validations: [Validation]
    
    public init(validations: [Validation]) {
        self.validations = validations
    }
        
    public func validate(data: [String : Any]?) -> String? {
        for validation in validations {
            if let errorMessage = validation.validate(data: data) {
                return errorMessage
            }
        }
        return nil
    }
}
