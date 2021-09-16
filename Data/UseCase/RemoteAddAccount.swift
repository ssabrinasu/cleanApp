//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Sabrina on 16/09/21.
//

import Foundation
import Domain

public final class RemoteAddAccount {
    private let url:URL
    private let HttpPostClient: HttpPostClient
    
    public init(url: URL, HttpPostClient: HttpPostClient) {
        self.url = url
        self.HttpPostClient = HttpPostClient
    }
    
    public func add(addAccountModel: AddAccountModel) {
        HttpPostClient.post(to: url, with: addAccountModel.toData())
    }
}
