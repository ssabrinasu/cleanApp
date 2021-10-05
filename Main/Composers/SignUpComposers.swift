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

public final class SignUpComposers {
    public static func composeControllerWith(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let presenter = SingUpPresenter(alertView: WeakVarProxy(controller), emailValidator: emailValidatorAdapter, addAccount: addAccount, loadingView: WeakVarProxy(controller))
        controller.signUp = presenter.singUp
        return controller
    }
}
