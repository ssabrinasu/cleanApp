//
//  TestFactories.swift
//  DataTests
//
//  Created by Sabrina on 21/09/21.
//

import Foundation

func makeEmptyData() -> Data {
    return Data()
}

func makeInvalidData() -> Data {
    return Data("Invalid_data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\":\"Rodrigo\"}".utf8)
}

func makeUrl() -> URL {
    return URL(string: "htt://any-url.com")!
}

func makeError() -> Error {
    return NSError(domain: "any_error", code: 0)
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
