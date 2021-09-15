//
//  AddAccountTests.swift
//  DataTests
//
//  Created by Sabrina on 15/09/21.
//

import XCTest
import Domain

class RemoteAddAccount {
    private let url:URL
    private let HttpPostClient: HttpPostClient
    
    init(url: URL, HttpPostClient: HttpPostClient) {
        self.url = url
        self.HttpPostClient = HttpPostClient
    }
    
    func add(addAccountModel: AddAccountModel) {
        let data = try? JSONEncoder().encode(addAccountModel)
        HttpPostClient.post(to: url, with: data)
    }
}

protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}

class RemoteAddAccountTests: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url() {
        guard let url = URL(string: "htt://any-url.com") else {return}
        let httClientSpy = HttpPostClientSpy()
        let sut = RemoteAddAccount(url: url, HttpPostClient: httClientSpy)
        let addAccountModel = AddAccountModel(name: "any name", email: "anyname@gmail.com", password: "12345", passwordConfiemation: "12345")
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httClientSpy.url, url)
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        guard let url = URL(string: "htt://any-url.com") else {return}
        let httClientSpy = HttpPostClientSpy()
        let sut = RemoteAddAccount(url: url, HttpPostClient: httClientSpy)
        let addAccountModel = AddAccountModel(name: "any name", email: "anyname@gmail.com", password: "12345", passwordConfiemation: "12345")
        let data = try? JSONEncoder().encode(addAccountModel)
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httClientSpy.data, data)
    }
}

extension RemoteAddAccountTests {
    class HttpPostClientSpy: HttpPostClient {
        var url: URL?
        var data: Data?
        
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}
