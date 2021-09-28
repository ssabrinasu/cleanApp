//
//  SingUpPresenterTests.swift
//  PresentationTests
//
//  Created by Sabrina on 24/09/21.
//

import XCTest

class SingUpPresenter {
    private let alertView: AlertView
    
    init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    func singUp(viewModel: SingUpViewModel) {
        
        if let message = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        }
    }
    
    private func validate(viewModel: SingUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            return "O campo Nome é obrigatorio"
        } else if viewModel.email == nil || viewModel.email!.isEmpty {
            return "O campo Email é obrigatorio"
        } else if viewModel.password == nil || viewModel.password!.isEmpty {
            return "O campo Senha é obrigatorio"
        } else if viewModel.passwordConfiemation == nil || viewModel.passwordConfiemation!.isEmpty {
            return "O campo Confirmar Senha é obrigatorio"
        }
        return nil
    }
}

protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

struct AlertViewModel: Equatable {
    var title: String?
    var message: String?
}

struct SingUpViewModel {
    var name: String?
    var email: String?
    var password: String?
    var passwordConfiemation: String?
}

class SingUpPresenterTests: XCTestCase {
    func test_singUp_should_show_error_message_if_name_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let singUpViewModel = SingUpViewModel(email: "any@email.com", password: "any12345", passwordConfiemation: "any12345")
        sut.singUp(viewModel: singUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatorio"))
    }
    
    func test_singUp_should_show_error_message_if_email_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let singUpViewModel = SingUpViewModel(name: "Any Name", password: "any12345", passwordConfiemation: "any12345")
        sut.singUp(viewModel: singUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatorio"))
    }
    
    func test_singUp_should_show_error_message_if_password_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let singUpViewModel = SingUpViewModel(name: "Any Name", email: "any@email.com", passwordConfiemation: "any12345")
        sut.singUp(viewModel: singUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Senha é obrigatorio"))
    }
    
    func test_singUp_should_show_error_message_if_password_confirmation_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let singUpViewModel = SingUpViewModel(name: "Any Name", email: "any@email.com", password: "any12345")
        sut.singUp(viewModel: singUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Confirmar Senha é obrigatorio"))
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
