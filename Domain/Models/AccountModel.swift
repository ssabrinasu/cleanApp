//
//  AccountModel.swift
//  Domain
//
//  Created by Sabrina on 15/09/21.
//

import Foundation

public struct AccountModel: Model {
    public var accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
