//
//  Model.swift
//  Domain
//
//  Created by Sabrina on 16/09/21.
//

import Foundation

public protocol Model: Encodable {}

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

