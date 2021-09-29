//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Sabrina on 21/09/21.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    return AccountModel(id: "a2", name: "any name", email: "anyname@gmail.com", password: "12345")
}

func makeAddAccountModel() -> AddAccountModel {
    return AddAccountModel(name: "any name", email: "anyname@gmail.com", password: "12345", passwordConfiemation: "12345")
}

