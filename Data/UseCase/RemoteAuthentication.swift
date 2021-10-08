//
//  RemoteAuthentication.swift
//  Data
//
//  Created by Sabrina on 08/10/21.
//

import Foundation
import Domain

public final class RemoteAuthentication {

    private let url:URL
    private let HttpClient: HttpPostClient
    
    public init(url: URL, HttpClient: HttpPostClient) {
        self.url = url
        self.HttpClient = HttpClient
    }
    
    public func auth(authenticationtModel: AuthenticationModel) {
        HttpClient.post(to: url, with: authenticationtModel.toData()) { _ in }
    }
}

