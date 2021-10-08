//
//  AddAccountTests.swift
//  DataTests
//
//  Created by Sabrina on 15/09/21.
//

import XCTest
import Domain
import Data

class RemoteAddAccountTests: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAddAccountModel()) { _ in }
        XCTAssertEqual(httClientSpy.urls, [url])
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, httClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel){ _ in }
        XCTAssertEqual(httClientSpy.data, addAccountModel.toData())
    }
    
    
    
    func test_add_should_comlete_with_email_if_use_error_client_completes_with_firbidden() {
        let (sut, httClientSpy) = makeSut()
        expect(sut, comleteWith: .failure(.emailInUse), when: {
            httClientSpy.completionWithError(.forbidden)
        })
    }
    
    func test_add_should_comlete_with_account_if_client_completes_with_data() {
        let (sut, httClientSpy) = makeSut()
        let account = makeAccountModel()
        expect(sut, comleteWith: .success(account), when: {
            httClientSpy.completionWithData(account.toData()!)
        })
    }
    
    func test_add_should_comlete_with_error_if_client_completes_with_invalid_data() {
        let (sut, httClientSpy) = makeSut()
        expect(sut, comleteWith: .failure(.unexpected), when: {
            httClientSpy.completionWithData(makeInvalidData())
        })
    }
    
    func test_add_should_not_comlete_if_sut_has_been_deallocated() {
        let httClientSpy = HttpClientSpy()
        var sut:  RemoteAddAccount? =  RemoteAddAccount(url: makeUrl(), HttpClient: httClientSpy)
        var result: AddAccount.Result?
        sut?.add(addAccountModel: makeAddAccountModel()) { result = $0 }
        sut = nil
        httClientSpy.completionWithError(.noConnectivity)
        XCTAssertNil(result)
    }

}

extension RemoteAddAccountTests {
    func makeSut(url: URL = URL(string: "htt://any-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteAddAccount, httClienteSpy: HttpClientSpy) {
        let httClientSpy = HttpClientSpy()
        let sut =  RemoteAddAccount(url: url, HttpClient: httClientSpy)
        checkMemoryLeak(for: httClientSpy, file: file, line: line)
        checkMemoryLeak(for: sut, file: file, line: line)
        return (sut, httClientSpy)
    }
    
    func expect(_ sut: RemoteAddAccount, comleteWith expectedResult: AddAccount.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel()) { receivedResult in
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
