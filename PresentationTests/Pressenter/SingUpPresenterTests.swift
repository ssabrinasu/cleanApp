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
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let singUpViewModel = SingUpViewModel(email: "any@email.com", password: "any12345", passwordConfirmation: "any12345")
        sut.singUp(viewModel: singUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatorio"))
    }
    
    func test_singUp_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let singUpViewModel = SingUpViewModel(name: "Any Name", password: "any12345", passwordConfirmation: "any12345")
        sut.singUp(viewModel: singUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatorio"))
    }
    
    func test_singUp_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let singUpViewModel = SingUpViewModel(name: "Any Name", email: "any@email.com", passwordConfirmation: "any12345")
        sut.singUp(viewModel: singUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Senha é obrigatorio"))
    }
    
    func test_singUp_should_show_error_message_if_password_confirmation_is_not_match() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let singUpViewModel = SingUpViewModel(name: "Any Name", email: "any@email.com", password: "any12345", passwordConfirmation: "any")
        sut.singUp(viewModel: singUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Falha ao confirmar senha"))
    }
    
    func test_singUp_should_show_emailValidator_with_correct_email() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
        let singUpViewModel = SingUpViewModel(name: "Any Name", email: "any@email.com", password: "any12345", passwordConfirmation: "any12345")
        sut.singUp(viewModel: singUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, singUpViewModel.email)
    }
    
    func test_singUp_should_show_error_message_if_invalid_email_is_provided() {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        let singUpViewModel = SingUpViewModel(name: "Any Name", email: "any@email.com", password: "any12345", passwordConfirmation: "any12345")
        emailValidatorSpy.isValid = false
        sut.singUp(viewModel: singUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Email inválido"))
    }
}

extension SingUpPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy()) -> SingUpPresenter {
        let sut = SingUpPresenter(alertView: alertView, emailValidator: emailValidator)
        return sut
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
    class EmailValidatorSpy: EmailValidator {
        var isValid = true
        var email: String?

        func isValid(email: String) -> Bool {
            self.email = email
            return isValid
        }

        func simulateInvalidEmail() {
               isValid = false
           }
       }
}
