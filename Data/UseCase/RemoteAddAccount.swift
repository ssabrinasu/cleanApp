//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Sabrina on 16/09/21.
//

import Foundation
import Domain

public final class RemoteAddAccount: AddAccount {

    private let url:URL
    private let HttpClient: HttpPostClient
    
    public init(url: URL, HttpClient: HttpPostClient) {
        self.url = url
        self.HttpClient = HttpClient
    }
    
    public func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        HttpClient.post(to: url, with: addAccountModel.toData()) { [weak self] Result in
            switch Result {
            case .success(let data):
                if let model: AccountModel = data.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure: completion(.failure(.unexpected))
            }
        }
    }
}

