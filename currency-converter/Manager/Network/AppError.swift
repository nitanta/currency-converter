//
//  AppError.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

public enum AppError: Error, Equatable {
  case corruptMetaData
  case internetConnectionError
  case unauthorized(metadata: HTTPURLResponse? = nil)
  case forbidden(metadata: HTTPURLResponse? = nil)
  case generic(metadata: HTTPURLResponse)
}
