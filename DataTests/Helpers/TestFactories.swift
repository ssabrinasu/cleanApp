//
//  TestFactories.swift
//  DataTests
//
//  Created by Sabrina on 21/09/21.
//

import Foundation

func makeInvalidData() -> Data {
    return Data("Invalid_data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\":\"Rodrigo\"}".utf8)
}

func makeUrl() -> URL {
    return URL(string: "htt://any-url.com")!
}
