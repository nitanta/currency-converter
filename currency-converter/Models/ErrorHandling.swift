//
//  ErrorHandling.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

enum APIErrors: Int, LocalizedError {
    case badRequest = 400
    case unAuthorized = 401
    case serverError = 500
    case notFound = 404
    
    var errorDescription: String? {
        switch self {
        case .serverError:
            return "Server error."
        case .notFound:
            return "The data you are looking is not out there."
        case .badRequest:
            return "Bad request."
        case .unAuthorized:
            return "Unauthorized request."
        }
    }
}

enum APIProviderErrors: LocalizedError {
    
    case invalidURL
    case dataNil
    case decodingError
    case unknownError
    case noInternet
    case customError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid url"
        case .dataNil:
            return "Empty data."
        case .decodingError:
            return "Data has invalid format."
        case .noInternet:
            return "You are not connected to the internet."
        case .customError(let description):
            return description
        default:
            return "Something went wrong."
        }
    }
}
