//
//  SignUpViewControllerTests.swift
//  UITests
//
//  Created by Sabrina on 30/09/21.
//

import XCTest
import UIKit
import Presentation
@testable import UI

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start()  {
        let sut = makeSut()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingVIew()  {
        let sut = makeSut()
        XCTAssertNotNil(sut as LoadingView)
    }
    
    func test_sut_implements_alertView()  {
        let sut = makeSut()
        XCTAssertNotNil(sut as AlertView)
    }
    
    func test_saveButton_calls_SignUp_on_tap()  {
        var singUpViewModel: SingUpViewModel?
        let sut = makeSut(signUpSpy: { singUpViewModel = $0 })
        sut.saveButton?.simulateTap()
        let name = sut.nameTextField?.text
        let email = sut.emailTextField?.text
        let password = sut.passwordTextField?.text
        let passwordConfirmation = sut.passwordConfirmationTextField?.text
        XCTAssertEqual(singUpViewModel, SingUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation))
    }
}

extension SignUpViewControllerTests {
    
    func makeSut(signUpSpy: ((SingUpViewModel) -> Void)? = nil) -> SignUpViewController {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        return sut
    }
}
