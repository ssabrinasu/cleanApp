//
//  AuthenticationSpy.swift
//  PresentationTests
//
//  Created by Sabrina on 09/10/21.
//

import Foundation
import Domain

class AuthenticationSpy: Authentication {
    var authenticationModel: AuthenticationModel?
    var completion: ((Authentication.Result) -> Void)?
    
    func auth(authenticationModel: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void) {
        self.authenticationModel = authenticationModel
        self.completion = completion
    }
    
    func completedWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completedWithAccout(_ account: AccountModel) {
        completion?(.success(account))
    }
}

