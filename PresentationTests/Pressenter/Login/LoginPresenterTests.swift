//
//  LoginPresenterTests.swift
//  PresentationTests
//
//  Created by Sabrina on 08/10/21.
//

import XCTest
import Presentation
import Domain

class LoginPresenterTests: XCTestCase {
    func test_singUp_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeSingUpViewModel()
        sut.singUp(viewModel: viewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to:viewModel.toJson()!))
    }
}

extension LoginPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), file: StaticString = #filePath, line: UInt = #line) -> LoginPresenter {
        let sut = SingUpPresenter(alertView: alertView, addAccount: addAccount, loadingView: loadingView, validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}


