//
//  SignUpViewController.swift
//  UI
//
//  Created by Sabrina on 30/09/21.
//

import Foundation
import UIKit
import Presentation

final class SignUpViewController: UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    
    var signUp: ((SingUpViewModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        saveButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc private func saveButtonTapped() {
        let viewModel = SingUpViewModel(name: nameTextField?.text,
                                        email: emailTextField?.text,
                                        password:passwordTextField?.text,
                                        passwordConfirmation: passwordConfirmationTextField?.text)
        
        signUp?(viewModel)
    }
}

extension SignUpViewController: LoadingView {
    func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            loadingIndicator?.startAnimating()
        } else {
            loadingIndicator?.stopAnimating()
        }
    }
}

extension SignUpViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        
    }
}
