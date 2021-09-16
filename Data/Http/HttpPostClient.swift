//
//  HttpPostClient.swift
//  Data
//
//  Created by Sabrina on 16/09/21.
//

import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}

