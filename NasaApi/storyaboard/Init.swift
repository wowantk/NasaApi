//
//  Incializator.swift
//  NasaApi
//
//  Created by macbook on 22.02.2021.
//

import Foundation
import UIKit
protocol Init{
    static var name: String { get }
    static var bundle: Bundle? { get }
    
    static func createFromStoryboard() -> Self
}

extension Init{
    static var name: String {
        return "Scroll"
    }
    
    static var bundle: Bundle? {
        return nil
    }
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static func createFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
