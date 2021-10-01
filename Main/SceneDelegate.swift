//
//  SceneDelegate.swift
//  Main
//
//  Created by Sabrina on 01/10/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let useCaseFactory = UseCaseFactory()
        window?.rootViewController = SignUpComposers.composeControllerWith(addAccount: useCaseFactory.makeRemoteAddAccount())
        window?.makeKeyAndVisible()
    }
}


