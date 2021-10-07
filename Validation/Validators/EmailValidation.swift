//
//  EmailValidation.swift
//  Validation
//
//  Created by Sabrina on 06/10/21.
//

import Foundation
import Presentation

public final class EmailValidation: Validation {
    private let fieldName: String
    private let fieldLabel: String
    private let emailValidator: EmailValidator
    
    public init(fieldName: String, fieldLabel: String, emailValidator: EmailValidator) {
        self.fieldLabel = fieldLabel
        self.fieldName = fieldName
        self.emailValidator = emailValidator
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let fieldValue = data?[fieldName] as? String, emailValidator.isValid(email: fieldValue) else {
            return "O campo \(fieldLabel) e invalido"
        }
        return nil
    }
}
