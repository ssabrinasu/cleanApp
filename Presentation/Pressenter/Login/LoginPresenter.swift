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
            self.loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            authentication.auth(authenticationModel: viewModel.toAuthenticatioModel()) { [weak self] result in
                guard let self = self else { return }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                switch result {
                case .failure(let error):
                    var errorMessage: String?
                    switch error {
                    case .expiredSession:
                        errorMessage = "Email e/ou senha invalidos."
                    default:
                        errorMessage =  "Algo inesperado aconteceu tente novamente em instantes"
                    }
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: errorMessage))
                    
                case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message:  "Conta logada com sucesso"))
                }
            }
        }
    }
}
