//
//  Authentication.swift
//  Domain
//
//  Created by Sabrina on 08/10/21.
//

import Foundation

public protocol Authentication {
    typealias Result = Swift.Result<AccountModel, DomainError>
    func add(authenticationModel: AddAccountModel, completion: @escaping (Result) -> Void)
}

public struct AuthenticationModel: Model {
    public var name: String
    public var email: String
    
    public init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}

