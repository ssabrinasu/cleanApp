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
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel()) { error in
            XCTAssertEqual(error, .unexpected)
            exp.fulfill()
        }
        httClientSpy.completionWithError(.noConnectivity)
        wait(for: [exp], timeout: 1)
    }
    
//    func test_add_should_comlete_with_account_if_client_completes_with_data() {
//        let (sut, httClientSpy) = makeSut()
//        let exp = expectation(description: "waiting")
//        sut.add(addAccountModel: makeAddAccountModel()) { error in
//            XCTAssertEqual(error, .unexpected)
//            exp.fulfill()
//        }
//        httClientSpy.completionWithError(.noConnectivity)
//        wait(for: [exp], timeout: 1)
//    }

}

extension RemoteAddAccountTests {
    func makeSut(url: URL = URL(string: "htt://any-url.com")!) -> (sut: RemoteAddAccount, httClienteSpy: HttpPostClientSpy) {
        let httClientSpy = HttpPostClientSpy()
        let sut =  RemoteAddAccount(url: url, HttpPostClient: httClientSpy)
        return (sut, httClientSpy)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "any name", email: "anyname@gmail.com", password: "12345", passwordConfiemation: "12345")
    }
    
    class HttpPostClientSpy: HttpPostClient {
        
        
        var urls = [URL]()
        var data: Data?
        var completion: ((HttpError) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping (HttpError) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completionWithError(_ error: HttpError) {
            completion?(error)
        }
    }
}
