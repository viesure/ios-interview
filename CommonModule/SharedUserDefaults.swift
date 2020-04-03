//
//  SharedUserDefaults.swift
//  CommonModule
//
//  Created by Nikola Malinovic on 01.04.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import Foundation
import ArticleModel

public final class SharedUserDefaults {
    
    public init() { }
    
    public var articlesData: Data? {
        get {
            guard let articles = UserDefaults.standard.value(forKey: String(describing: Article.self)) as? Data else {
                return nil
            }
            return articles
        }
        set {
            guard let newValue = newValue else { return }
            saveValueForKey(value: newValue, key: String(describing: Article.self))
        }
    }
    
    public func saveValueForKey(value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    public func readValueForKey(key: String) -> [Article] {
        guard let value = UserDefaults.standard.value(forKey: key) as? Data else { return [] }
        do {
            let response = try JSONDecoder().decode([Article].self, from:value)
            return response
        } catch {
            #if DEBUG
            print("Could not decode persited article data")
            #endif
        }
        return []
    }
    
    public func hasValue(forKey key: String) -> Bool {
        return nil != UserDefaults.standard.object(forKey: key)
    }
}
