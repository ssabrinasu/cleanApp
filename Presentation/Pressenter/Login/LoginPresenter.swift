//
//  LoginPresenter.swift
//  Presentation
//
//  Created by Sabrina on 09/10/21.
//

import Foundation
import Domain

public final class LoginPresenter {
    private let alertView: AlertView
    private let authentication: Authentication
    private let loadingView: LoadingView
    private let validation: Validation

    public init(alertView: AlertView, authentication: Authentication, loadingView: LoadingView, validation: Validation) {
        self.alertView = alertView
        self.authentication = authentication
        self.loadingView = loadingView
        self.validation = validation
    }
    
    public func login(viewModel: LoginViewModel) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            authentication.auth(authenticationModel: viewModel.toAuthenticatioModel()) { _ in }
        }
    }
}
