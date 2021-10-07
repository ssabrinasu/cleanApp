//
//  RequiredFieldValidation.swift
//  Validation
//
//  Created by Sabrina on 06/10/21.
//

import Foundation
import Presentation

public class RequiredFieldValidation: Validation, Equatable {

    private let fieldName: String
    private let fieldLabel: String
    
    public init(fieldName: String, fieldLabel: String) {
        self.fieldLabel = fieldLabel
        self.fieldName = fieldName
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let fieldName = data?[fieldName] as? String, !fieldName.isEmpty else {
            return "O campo \(fieldLabel) e obrigatorio"
        }
        return nil
    }
    
    public static func == (lhs: RequiredFieldValidation, rhs: RequiredFieldValidation) -> Bool {
        return lhs.fieldLabel == rhs.fieldLabel && lhs.fieldName == rhs.fieldName
    }
}
