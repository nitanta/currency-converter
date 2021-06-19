//
//  Utilities.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation
import UIKit

struct Utilities {
    
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    static func loadStub<D: Decodable>(url: URL) -> D? {
        let data = try! Data(contentsOf: url)
        do {
            let d = try jsonDecoder.decode(D.self, from: data)
            return d
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func loadStubData(url: URL) -> Data? {
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static var getFilePath: String {
        let urls = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        return "FILE PATH: \(urls.last)"
    }
    
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
