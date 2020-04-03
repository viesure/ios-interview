//
//  Environment.swift
//  Articles
//
//  Created by Nikola Malinovic on 31.03.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import Foundation

public enum Environment: String {
    case prod = "" // ?
    case dev = "http://viesure.free.beeceptor.com/"
    
    var url: URL {
        return URL(string: self.rawValue)!
    }
    
    static var `default`: Environment {
        return .dev
    }
    
    private static var currentKey: String { "Environment.currentKey" }
    static var current: Environment {
        get {
            if let storedEnv = UserDefaults.standard.string(forKey: currentKey) {
                return Environment(rawValue: storedEnv) ?? `default`
            } else {
                return `default`
            }
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: currentKey)
        }
    }
}
