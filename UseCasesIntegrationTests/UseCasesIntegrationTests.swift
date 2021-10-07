//
//  UseCasesIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by Sabrina on 23/09/21.
//

import XCTest
import Data
import Infra
import Domain

//class AddAccountIntegrationTests: XCTestCase {
//    func test_add_account() {
//        let alamofireAdapter = AlamofireAdapter()
//        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
//        let sut = RemoteAddAccount(url: url, HttpClient: alamofireAdapter)
//        let addAccountModel = AddAccountModel(name: "Rodrigo Manguinho", email: "rodrigo.manguinho@gmail.com", password: "secret", passwordConfiemation: "secret")
//        let exp = expectation(description: "waiting")
//        sut.add(addAccountModel: addAccountModel) { result in
//            switch result {
//            case .failure: XCTFail("Expect success got \(result) instead")
//            case .success(let account):
//                XCTAssertNotNil(account.accessToken)
//            }
//            exp.fulfill()
//        }
//        wait(for: [exp], timeout: 5)
//    }
//}
