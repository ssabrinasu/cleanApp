//
//  WelcomeViewController.swift
//  UI
//
//  Created by Sabrina on 12/10/21.
//

import Foundation
import UIKit


public final class WelcomeViewController: UIViewController, Storyboarded {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var singUpButton: UIButton!
    
    public var login: (() -> Void)?

    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
 
    private func configure() {
        title = "4Devs"
        loginButton?.layer.cornerRadius = 5
        loginButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        hideKeyBoardOnTap()
    }
 
    @objc private func saveButtonTapped() {
        login?()
    }
}

