//
//  Utilities.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation
import UIKit

struct Utilities {
    
    /// JSON decoder
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    
    /// Load stub response model
    /// - Parameters:
    ///   - type: Type of object, decodable
    ///   - url: url to load data from
    /// - Throws: throws error
    /// - Returns: return decodable object
    static func loadStub<T>(_ type: T.Type, from url: URL) throws -> T? where T : Decodable {
        let data = try! Data(contentsOf: url)
        do {
            let d = try jsonDecoder.decode(T.self, from: data)
            return d
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    /// Load data from url
    /// - Parameter url: file url from the bundle
    /// - Returns: returns data
    static func loadStubData(url: URL) -> Data? {
        let data = try! Data(contentsOf: url)
        return data
    }
    
    /// File path for the application directory
    static var getFilePath: String {
        let urls = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        return "FILE PATH: \(String(describing: urls.last))"
    }
    
    /// Customize the navigation bar for the app
    static func navigationBarCustomize() {
       let appearance = UINavigationBarAppearance()
       appearance.configureWithTransparentBackground()
       appearance.largeTitleTextAttributes = [
        .font : UIFont(name: "Menlo-Bold", size: 32) as Any,
        NSAttributedString.Key.foregroundColor : UIColor.black
       ]
       appearance.titleTextAttributes = [
        .font : UIFont(name: "Menlo-Bold", size: 24) as Any,
        NSAttributedString.Key.foregroundColor : UIColor.black
       ]
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().backgroundColor = .clear
    }
       
}
