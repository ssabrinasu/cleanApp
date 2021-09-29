//
//  EmailValidators.swift
//  Presentation
//
//  Created by Sabrina on 27/09/21.
//

import Foundation

public protocol EmailValidator {
    func isValid(email: String) -> Bool
}
