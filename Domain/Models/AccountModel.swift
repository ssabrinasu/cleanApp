//
//  AccountModel.swift
//  Domain
//
//  Created by Sabrina on 15/09/21.
//

import Foundation

public struct AccountModel: Model {
    public var accessToken: String
    public var name: String
    public var email: String
    public var password: String
    
    public init(accessToken: String, name: String, email: String, password: String) {
        self.accessToken = accessToken
        self.name = name
        self.email = email
        self.password = password
      
    }
}

