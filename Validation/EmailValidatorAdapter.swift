//
//  EmailValidatorAdapter.swift
//  Validation
//
//  Created by Sabrina on 30/09/21.
//

import Foundation
import Presentation

public class EmailValidatorAdapter: EmailValidator {
    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    public init() {}
    
    public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf8.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }

}
