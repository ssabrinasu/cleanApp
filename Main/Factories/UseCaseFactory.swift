//
//  UseCaseFactory.swift
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

public class UseCaseFactory {
    func makeRemoteAddAccount() -> AddAccount {
        let alamofireAdapter = AlamofireAdapter ()
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        return RemoteAddAccount(url: url, HttpClient: alamofireAdapter)
    }
}
