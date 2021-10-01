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

class SignUpFactory {
    static func makeController() -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let alamofireAdapter = AlamofireAdapter ()
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        let remoteAddAccount = RemoteAddAccount(url: url, HttpClient: alamofireAdapter)
        let presenter = SingUpPresenter(alertView: controller, emailValidator: emailValidatorAdapter, addAccount: remoteAddAccount, loadingView: controller)
        controller.signUp = presenter.singUp
        return controller
    }
}
