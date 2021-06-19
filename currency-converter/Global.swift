//
//  Global.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/17/21.
//

import Foundation

struct Global {
    static var baseUrl: String{
       return "http://api.currencylayer.com"
    }
    static var apiKey: String {
        return "72cb1057044dd201006fc5bc22868181"
    }
    static var defaultCode: String {
        return "USD"
    }
}
