//
//  LoginPresenter.swift
//  Presentation
//
//  Created by Sabrina on 09/10/21.
//

import Foundation
import Domain

public final class SingUpPresenter {
    private let validation: Validation

    public init(alidation: Validation) {
        self.validation = validation
    }
    
    public func login(viewModel: LoginViewModel) {
        _ validation.validate(data: viewModel.toJson())
    }
}
