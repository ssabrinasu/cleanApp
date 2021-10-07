//
//  SignUpComposers.swift
//  Main
//
//  Created by Sabrina on 01/10/21.
//

import Foundation
import UI
import Presentation
import Validation
import Domain
import Infra

public final class SignUpComposers {
    public static func composeControllerWith(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let validationComposite = ValidationComposite(validations: makeValidations())
        let presenter = SingUpPresenter(alertView: WeakVarProxy(controller),
                                        addAccount: addAccount,
                                        loadingView: WeakVarProxy(controller),
                                        validation: validationComposite)
        controller.signUp = presenter.singUp
        return controller
    }
    
    public static func makeValidations() -> [Validation] {
        return [
            RequiredFieldValidation(fieldName: "nome", fieldLabel: "Nome"),
            RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
            EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorAdapter()),
            RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
            RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"),
            CompareFieldsValidation(fieldName: "password", fieldLabel: "Confirmar Senha", fieldNameToCompare: "passwordConfirmation")
        ]
    }
}
