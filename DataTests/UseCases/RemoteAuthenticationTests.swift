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
    func test_auth_should_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httClientSpy) = makeSut(url: url)
        sut.auth(authenticationModel: makeAuthenticationtModel()) { _ in }
        XCTAssertEqual(httClientSpy.urls, [url])
    }
    func test_auth_should_call_httpClient_with_correct_data() {
        let (sut, httClientSpy) = makeSut()
        let authenticationtModel = makeAuthenticationtModel()
        sut.auth(authenticationModel: authenticationtModel) { _ in }
        XCTAssertEqual(httClientSpy.data, authenticationtModel.toData())
    }
    func test_auth_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httClientSpy) = makeSut()
        expect(sut, comleteWith: .failure(.unexpected), when: {
            httClientSpy.completionWithError(.noConnectivity)
        })
    }
    func test_auth_should_complete_with_expired_session_error_if_client_completes_with_unauthorized() {
        let (sut, httClientSpy) = makeSut()
        expect(sut, comleteWith: .failure(.expiredSession), when: {
            httClientSpy.completionWithError(.unauthorized)
        })
    }
    func test_auth_should_complete_with_account_if_client_completes_with_valid_data() {
        let (sut, httClientSpy) = makeSut()
        let account = makeAccountModel()
        expect(sut, comleteWith: .success(account), when: {
            httClientSpy.completionWithData(account.toData()!)
        })
    }
    
    func test_auth_should_complete_with_error_if_client_completes_with_invalid_data() {
        let (sut, httClientSpy) = makeSut()
        expect(sut, comleteWith: .failure(.unexpected), when: {
            httClientSpy.completionWithData(makeInvalidData())
        })
    }
    
    func test_auth_should_not_complete_if_sut_has_been_deallocated() {
        let httClientSpy = HttpClientSpy()
        var sut:  RemoteAuthentication? =  RemoteAuthentication(url: makeUrl(), HttpClient: httClientSpy)
        var result: Authentication.Result?
        sut?.auth(authenticationModel: makeAuthenticationtModel()) { result = $0 }
        sut = nil
        httClientSpy.completionWithError(.noConnectivity)
        XCTAssertNil(result)
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
        sut.auth(authenticationModel: makeAuthenticationtModel()) { receivedResult in
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
    
