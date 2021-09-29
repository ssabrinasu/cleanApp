//
//  SingUpPresenter.swift
//  Presentation
//
//  Created by Sabrina on 27/09/21.
//

import Foundation
import Domain

public final class SingUpPresenter {
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    private let addAccount: AddAccount

    public  init(alertView: AlertView, emailValidator: EmailValidator, addAccount: AddAccount ) {
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
    }
    
    public func singUp(viewModel: SingUpViewModel) {
        
        if let message = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            let addAccountModel = AddAccountModel(name: viewModel.name!, email: viewModel.email!, password: viewModel.password!, passwordConfiemation: viewModel.passwordConfirmation!)
            addAccount.add(addAccountModel: addAccountModel) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "Algo inesperado aconteceu tente novamente em instantes"))
                case .success: break
                }
            }
        }
    }
    
    private func validate(viewModel: SingUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            return "O campo Nome é obrigatorio"
        } else if viewModel.email == nil || viewModel.email!.isEmpty {
            return "O campo Email é obrigatorio"
        } else if viewModel.password == nil || viewModel.password!.isEmpty {
            return "O campo Senha é obrigatorio"
        } else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
            return "O campo Confirmar Senha é obrigatorio"
        } else if viewModel.password != viewModel.passwordConfirmation {
            return "O campo Confirmar Senha é inválido"
        } else if !emailValidator.isValid(email: viewModel.email!) {
            return "O campo Email é inválido"
        }
        return nil
    }
}

public struct SingUpViewModel {
    public var name: String?
    public var email: String?
    public var password: String?
    public var passwordConfirmation: String?
    
    public init (name: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
