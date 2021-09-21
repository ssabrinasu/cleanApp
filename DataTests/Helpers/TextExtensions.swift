//
//  TextExtensions.swift
//  DataTests
//
//  Created by Sabrina on 21/09/21.
//

import Foundation
import XCTest

extension XCTestCase{
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
