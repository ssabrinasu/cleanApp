//
//  RemoteAuthenticationTests.swift
//  DataTests
//
//  Created by Sabrina on 08/10/21.
//
import XCTest
import Domain
import Data

class RemoteAuthenticationTests: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httClientSpy) = makeSut(url: url)
        sut.auth()
        XCTAssertEqual(httClientSpy.urls, [url])
    }
}

extension RemoteAuthenticationTests {
    func makeSut(url: URL = URL(string: "htt://any-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteAuthentication, httClienteSpy: HttpClientSpy) {
        let httClientSpy = HttpClientSpy()
        let sut =  RemoteAuthentication(url: url, HttpClient: httClientSpy)
        checkMemoryLeak(for: httClientSpy, file: file, line: line)
        checkMemoryLeak(for: sut, file: file, line: line)
        return (sut, httClientSpy)
    }
}
