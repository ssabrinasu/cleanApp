//
//  UIViewControllerExtensions.swift
//  UI
//
//  Created by Sabrina on 30/09/21.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyBoardOnTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func hideKeyBoard() {
        view.endEditing(true)
    }
    
}
