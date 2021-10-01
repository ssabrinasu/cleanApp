//
//  SignUpComposers.swift
//  Main
//
//  Created by Sabrina on 01/10/21.
//

import Foundation
import Domain
import UI

public final class SignUpComposers {
    public static func composeControllerWith(addAccount: AddAccount) -> SignUpViewController {
        return ControllerFactory.makeController(addAccount: addAccount)
    }
}
