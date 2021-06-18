//
//  AppEndpoint.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

public enum HTTPMethod: String {
    case get
    case post
    case delete
    case update
    case put
}

public enum ParameterEncoding {
    case json
    case url
    case urlformencoded
    case none
}

protocol EndpointProtocol {
    var baseURL: String { get }
    var absoluteURL: String { get }
    var params: [String: Any] { get }
    var arrayParams: [Any] { get }
    var headers: [String: String] { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}


enum AppEndpoint: EndpointProtocol {
    case fetchRates(code: String)

    var baseURL: String {
        return Global.baseUrl
    }
    
    var absoluteURL: String {
        switch self {
        case .fetchRates:
            return baseURL + "/live"
        }
    }
    
    var params: [String: Any] {
        switch self {
        case .fetchRates(let code):
            return ["access_key": Global.apiKey, "currencies": code]
        }
    }
    
    var arrayParams: [Any] {
        return []
    }
    
    var headers: [String: String] {
        return [
            "Content-type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchRates:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .fetchRates:
            return .url
        }
    }
}
