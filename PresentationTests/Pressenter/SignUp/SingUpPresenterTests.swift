//
//  SingUpPresenterTests.swift
//  PresentationTests
//
//  Created by Sabrina on 24/09/21.
//

import XCTest
import Presentation
import Domain

class SingUpPresenterTests: XCTestCase {
    func test_singUp_should_call_addAccount_with_correct_values() {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)
        sut.singUp(viewModel: makeSingUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }
    
    func test_singUp_should_show_generic_error_message_if_addAccount_fails() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Error", message: "Algo inesperado aconteceu tente novamente em instantes"))
            exp.fulfill()
        }
        
        sut.singUp(viewModel: makeSingUpViewModel())
        addAccountSpy.completedWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    
    }
    
    func test_singUp_should_show_email_in_use_error_message_if_addAccount_returns_email_in_use_errror() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Error", message: "Esse e-mail ja esta em uso."))
            exp.fulfill()
        }
        
        sut.singUp(viewModel: makeSingUpViewModel())
        addAccountSpy.completedWithError(.emailInUse)
        wait(for: [exp], timeout: 1)
    
    }
    
    
    func test_singUp_should_show_success_message_if_addAccount_succeds() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso"))
            exp.fulfill()
        }
        sut.singUp(viewModel: makeSingUpViewModel())
        addAccountSpy.completedWithAccout(makeAccountModel())
        wait(for: [exp], timeout: 1)
    
    }
    
    func test_singUp_should_show_loading_before_and_after_addAcount() {
        let loadingViewSpy = LoadingViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy, loadingView: loadingViewSpy)
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        sut.singUp(viewModel: makeSingUpViewModel())
        wait(for: [exp], timeout: 1)
        
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            exp2.fulfill()
        }
        addAccountSpy.completedWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }
    
    func test_singUp_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeSingUpViewModel()
        sut.singUp(viewModel: viewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to:viewModel.toJson()!))
    }
    
    func test_singUp_should_show_error_message_if_validation_false() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Error"))
            exp.fulfill()
        }
        validationSpy.simulateError()
        sut.singUp(viewModel: makeSingUpViewModel())
        wait(for: [exp], timeout: 1)
    }
}

extension SingUpPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), addAccount: AddAccountSpy = AddAccountSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), validation: ValidationSpy = ValidationSpy(), file: StaticString = #filePath, line: UInt = #line) -> SingUpPresenter {
        let sut = SingUpPresenter(alertView: alertView, addAccount: addAccount, loadingView: loadingView, validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
