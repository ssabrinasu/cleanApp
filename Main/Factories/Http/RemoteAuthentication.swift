//
//  RemoteAuthentication.swift
//  Main
//
//  Created by Sabrina on 12/10/21.
//
import Foundation
import Data
import Infra
import Domain

func makeRemoteAuthentication(httpClient: HttpPostClient) -> Authentication {
        let remoteAuthentication =  RemoteAuthentication(url: makeApiUrl(path: "login"), HttpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAuthentication) as! Authentication
}
