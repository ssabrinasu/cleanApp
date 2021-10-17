//
//  RemoteAddAccountFactory.swift
//  Main
//
//  Created by Sabrina on 08/10/21.
//
import Foundation
import Data
import Infra
import Domain

func makeRemoteAddAccount() -> AddAccount {
    return makeRemoteAddAccountWith(httpClient: makeAlamofireAdapter())
}

public func makeRemoteAddAccountWith(httpClient: HttpPostClient) -> AddAccount {
        let remoteAddAccount =  RemoteAddAccount(url: makeApiUrl(path: "signup"), HttpClient: httpClient)
        return MainQueueDispatchDecorator(remoteAddAccount)
}
