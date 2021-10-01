//
//  SignUpFactory.swift
//  Main
//
//  Created by Sabrina on 01/10/21.
//

import Foundation
import UI
import Presentation
import Validation
import Data
import Infra
import Domain

class ControllerFactory {
    static func makeController(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let presenter = SingUpPresenter(alertView: WeakVarProxy(controller), emailValidator: emailValidatorAdapter, addAccount: addAccount, loadingView: WeakVarProxy(controller))
        controller.signUp = presenter.singUp
        return controller
    }
}
