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
    func test_Auth_should_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httClientSpy) = makeSut(url: url)
        sut.auth(authenticationtModel: makeAuthenticationtModel()) { _ in }
        XCTAssertEqual(httClientSpy.urls, [url])
    }
    func test_Auth_should_call_httpClient_with_correct_data() {
        let (sut, httClientSpy) = makeSut()
        let authenticationtModel = makeAuthenticationtModel()
        sut.auth(authenticationtModel: authenticationtModel) { _ in }
        XCTAssertEqual(httClientSpy.data, authenticationtModel.toData())
    }
    func test_add_should_comlete_with_error_if_client_completes_with_error() {
        let (sut, httClientSpy) = makeSut()
        expect(sut, comleteWith: .failure(.unexpected), when: {
            httClientSpy.completionWithError(.noConnectivity)
        })
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
    func expect(_ sut: RemoteAuthentication, comleteWith expectedResult: Authentication.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.auth(authenticationtModel: makeAuthenticationtModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            default: XCTFail("Exected \(expectedResult) receive \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
    
