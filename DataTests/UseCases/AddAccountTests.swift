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
        guard let url = URL(string: "htt://any-url.com") else {return}
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
    
    func test_add_should_comlete_with_error_if_client_completes_with_error() {
        let (sut, httClientSpy) = makeSut()
        expect(sut, comleteWith: .failure(.unexpected), when: {
            httClientSpy.completionWithError(.noConnectivity)
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
            httClientSpy.completionWithData(Data("Invalid_data".utf8))
        })
    }

}

extension RemoteAddAccountTests {
    func makeSut(url: URL = URL(string: "htt://any-url.com")!) -> (sut: RemoteAddAccount, httClienteSpy: HttpClientSpy) {
        let httClientSpy = HttpClientSpy()
        let sut =  RemoteAddAccount(url: url, HttpClient: httClientSpy)
        return (sut, httClientSpy)
    }
    
    func expect(_ sut: RemoteAddAccount, comleteWith expectedResult: Result<AccountModel, DomainError>, when action: () -> Void) {
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount)
            default: XCTFail("Exected \(expectedResult) receive \(receivedResult) instead")
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "any name", email: "anyname@gmail.com", password: "12345", passwordConfiemation: "12345")
    }
    
    func makeAccountModel() -> AccountModel {
        return AccountModel(id: "a2", name: "any name", email: "anyname@gmail.com", password: "12345")
    }

    
    class HttpClientSpy: HttpPostClient {
        var urls = [URL]()
        var data: Data?
        var completion: ((Result<Data, HttpError>) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completionWithError(_ error: HttpError) {
            completion?(.failure(error))
        }
        
        func completionWithData(_ data: Data) {
            completion?(.success(data))
        }
    }
}
