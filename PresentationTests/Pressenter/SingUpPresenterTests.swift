//
//  SingUpPresenterTests.swift
//  PresentationTests
//
//  Created by Sabrina on 24/09/21.
//

import XCTest
import Presentation

class SingUpPresenterTests: XCTestCase {
    func test_singUp_should_show_error_message_if_name_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let singUpViewModel = SingUpViewModel(email: "any@email.com", password: "any12345", passwordConfirmation: "any12345")
        sut.singUp(viewModel: singUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatorio"))
    }
    
    func test_singUp_should_show_error_message_if_email_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let singUpViewModel = SingUpViewModel(name: "Any Name", password: "any12345", passwordConfirmation: "any12345")
        sut.singUp(viewModel: singUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatorio"))
    }
    
    func test_singUp_should_show_error_message_if_password_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let singUpViewModel = SingUpViewModel(name: "Any Name", email: "any@email.com", passwordConfirmation: "any12345")
        sut.singUp(viewModel: singUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Senha é obrigatorio"))
    }
    
    func test_singUp_should_show_error_message_if_password_confirmation_is_not_match() {
        let (sut, alertViewSpy) = makeSut()
        let singUpViewModel = SingUpViewModel(name: "Any Name", email: "any@email.com", password: "any12345", passwordConfirmation: "any")
        sut.singUp(viewModel: singUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Falha ao confirmar senha"))
    }
}

extension SingUpPresenterTests {
    func makeSut() -> (sut: SingUpPresenter, AlertViewSpy: AlertViewSpy) {
        let alertViewSpy = AlertViewSpy()
        let sut = SingUpPresenter(alertView: alertViewSpy)
        return (sut, alertViewSpy)
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
}
