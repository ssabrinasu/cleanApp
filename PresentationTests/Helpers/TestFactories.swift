//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Sabrina on 29/09/21.
//

import Foundation
import Presentation
import Domain

func makeSingUpViewModel(name: String? = "any name", email: String? = "anyname@gmail.com", password: String? = "12345", passwordConfirmation: String? = "12345") -> SingUpRequest {
    return SingUpRequest(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    
}

func makeLoginViewModel(email: String? = "anyname@gmail.com", password: String? = "12345") -> LoginRequest {
    return LoginRequest(email: email, password: password)
}

func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
    return AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é obrigatorio")
}

func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
    return AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é inválido")
}

func makeErrorAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Error", message: message)
}

func makeSuccessAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Sucesso", message: message)
}
