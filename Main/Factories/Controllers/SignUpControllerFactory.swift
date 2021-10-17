//
//  SignUpControllerFactory.swift
//  Main
//
//  Created by Sabrina on 08/10/21.
//

import Foundation
import UI
import Presentation
import Validation
import Domain

public func makeSignUpController() -> SignUpViewController {
    return makeSignUpControllerWith(addAccount: makeRemoteAddAccount())
}

public func makeSignUpControllerWith(addAccount: AddAccount) -> SignUpViewController {
    let controller = SignUpViewController.instantiate()
    let validationComposite = ValidationComposite(validations: makeSignUpValidations())
    let presenter = SingUpPresenter(alertView: WeakVarProxy(controller),
                                    addAccount: addAccount,
                                    loadingView: WeakVarProxy(controller),
                                    validation: validationComposite)
    controller.signUp = presenter.singUp
    return controller
}

public func makeSignUpValidations() -> [Validation] {
    return [
        RequiredFieldValidation(fieldName: "nome", fieldLabel: "Nome"),
        RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
        EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: makeEmailValidatorAdapter()),
        RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
        RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"),
        CompareFieldsValidation(fieldName: "password", fieldLabel: "Confirmar Senha", fieldNameToCompare: "passwordConfirmation")
    ]
}

