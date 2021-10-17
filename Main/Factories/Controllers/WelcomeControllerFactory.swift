//
//  WelcomeControllerFactory.swift
//  Main
//
//  Created by Sabrina on 17/10/21.
//

import Foundation


import Foundation
import UI
import Presentation
import Validation
import Domain

public func makeWelcomeController(nav: NavigationController) -> WelcomeViewController {
    let router = WelcomeRouter(nav: nav, loginFactory: makeLoginController, signUpFactory: makeSignUpController)
    let controller = WelcomeViewController.instantiate()
    controller.signUp = router.goToSignUp
    controller.login = router.goToLogin
    return controller
}
