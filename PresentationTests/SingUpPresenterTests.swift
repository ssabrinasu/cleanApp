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
        if viewModel.name == nil || viewModel.name!.isEmpty {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validacao", message: "O campo Nome e obrigatorio"))
        }
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
    func test_singUp() {
        let alertViewSpy = AlertViewSpy()
        let sut = SingUpPresenter(alertView: alertViewSpy)
        let singUpViewModel = SingUpViewModel(email: "any@email.com", password: "any12345", passwordConfiemation: "any12345")
        sut.singUp(viewModel: singUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validacao", message: "O campo Nome e obrigatorio"))
    }
}

extension SingUpPresenterTests {
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
}
