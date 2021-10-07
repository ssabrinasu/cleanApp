//
//  CompareFieldsValidation.swift
//  Validation
//
//  Created by Sabrina on 06/10/21.
//

import Foundation
import Presentation

public final class CompareFieldsValidation: Validation, Equatable {
    
    private let fieldName: String
    private let fieldNameToCompare: String
    private let fieldLabel: String
    
    public init(fieldName: String, fieldLabel: String, fieldNameToCompare: String) {
        self.fieldLabel = fieldLabel
        self.fieldName = fieldName
        self.fieldNameToCompare = fieldNameToCompare
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let fieldName = data?[fieldName] as? String,
              let fieldNameToCompare = data?[fieldNameToCompare] as? String, fieldName == fieldNameToCompare else {
            return "O campo \(fieldLabel) e invalido"
        }
        return nil
    }
    
    public static func == (lhs: CompareFieldsValidation, rhs: CompareFieldsValidation) -> Bool {
        return lhs.fieldLabel == rhs.fieldLabel && lhs.fieldName == rhs.fieldName && lhs.fieldNameToCompare == rhs.fieldNameToCompare
    }
}
