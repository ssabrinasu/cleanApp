//
//  SceneDelegate.swift
//  Main
//
//  Created by Sabrina on 01/10/21.
//

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    let httpClient = makeAlamofireAdapter()
    
    private let signUpFactory: () -> SignUpViewController = {
        let httpClient = makeAlamofireAdapter()
        let remoteAddAccount = makeRemoteAddAccount(httpClient: httpClient)
        return makeSignUpController(addAccount: remoteAddAccount)
    }
    
    private let loginFactory: () -> LoginViewController = {
        let httpClient = makeAlamofireAdapter()
        let remoteAuthentication = makeRemoteAuthentication(httpClient: httpClient)
        return makeLoginController(authentication: remoteAuthentication)
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let nav = NavigationController()
        let welcomeRouter = WelcomeRouter(nav: nav, loginFactory: loginFactory, signUpFactory: signUpFactory)
        let welcomeViewController = WelcomeViewController.instantiate()
        welcomeViewController.signUp = welcomeRouter.goToSignUp
        welcomeViewController.login = welcomeRouter.goToLogin
        nav.setRootViewController(welcomeViewController)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}


 
