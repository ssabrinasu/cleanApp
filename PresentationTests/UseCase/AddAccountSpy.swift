//
//  AddAccountSpy.swift
//  PresentationTests
//
//  Created by Sabrina on 29/09/21.
//

import Foundation
import Domain


class AddAccountSpy: AddAccount {
    var addAccountModel: AddAccountModel?
    var completion: ((AddAccount.Result) -> Void)?
    
    func add(addAccountModel: AddAccountModel, completion: @escaping (AddAccount.Result) -> Void) {
        self.addAccountModel = addAccountModel
        self.completion = completion
    }
    
    func completedWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completedWithAccout(_ account: AccountModel) {
        completion?(.success(account))
    }
}
