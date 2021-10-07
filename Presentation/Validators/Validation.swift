//
//  Validation.swift
//  Presentation
//
//  Created by Sabrina on 05/10/21.
//

import Foundation

public protocol Validation {
    func validate(data: [String: Any]?) -> String?
}
