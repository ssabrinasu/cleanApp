//
//  AddAccount.swift
//  Domain
//
//  Created by Sabrina on 15/09/21.
//

import Foundation

public protocol AddAccount{
    func add(addAccountModel: AddAccountModel, completion: (Result<AccountModel, Error>) -> Void)
}

public struct AddAccountModel: Encodable {
    public var name: String
    public var email: String
    public var password: String
    public var passwordConfiemation: String
    
    public init(name: String, email: String, password: String, passwordConfiemation: String) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfiemation = passwordConfiemation
    }
}

