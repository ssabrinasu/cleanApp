//
//  HttpError.swift
//  Data
//
//  Created by Sabrina on 17/09/21.
//

import Foundation

public enum HttpError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}
