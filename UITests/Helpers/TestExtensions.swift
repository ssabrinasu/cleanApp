//
//  TestExtensions.swift
//  UITests
//
//  Created by Sabrina on 30/09/21.
//

import Foundation
import UIKit

extension UIControl {
    func simulate(event: UIButton.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach { action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }
    
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
    
}
