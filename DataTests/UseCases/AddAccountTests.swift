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
        sut.add(addAccountModel: makeAddAccountModel())
        XCTAssertEqual(httClientSpy.url, url)
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, httClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httClientSpy.data, addAccountModel.toData())
    }
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
        var url: URL?
        var data: Data?
        
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}
