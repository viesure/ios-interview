//
//  ApiCache.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation

protocol ApiCacheProtocol {
    var wrapped: NSCache<WrappedKey, WrappedValue> { get set }
    var dateProvider: ()->Date  { get }
    var entryLifeTime: TimeInterval  { get }
    var persistProvider: ApiCachePersistProviderProtocol?  { get }

    func insert(value: Data, forKey key: URL)
    func value(forKey key: URL, cachePolicy: CachePolicy) -> (source: Source, data: Data)?
    func removeValue(forKey key: URL)
}

enum Source {
    case backend(age: Date)
    case memCache(age: Date)
    case persistedCache(age: Date)

    func stringRepresentation() -> String {
        switch self {
        case .backend:
            return "backend"
        case .memCache:
            return "memCache"
        case .persistedCache:
            return "persistedCache"
        }
    }

    func age() -> Date {
        switch self {
        case .backend(let age), .memCache(let age), .persistedCache(let age):
            return age
        }
    }
}

enum CachePolicy {
    // Returns valid cache from memory
    case normal
    // Returns cache from memory (can return old cache), else returns persisted cache
    case force
}

struct Cache: Codable {
    let data: Data
    let age: Date

    init(value: Data) {
        self.data = value
        self.age = Date()
    }

    init(value: Data, age: Date) {
        self.data = value
        self.age = age
    }

}

final class WrappedKey: NSObject {
    let key: URL

    init(key: URL) {
        self.key = key
    }

    override var hash: Int {
        return key.hashValue
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let value = object as? WrappedKey else {
            return false
        }

        return value.key == key
    }
}

final class WrappedValue {
    let value: Cache
    let expirationDate: Date

    init(value: Cache, expirationDate: Date) {
        self.value = value
        self.expirationDate = expirationDate
    }
}

final class ApiCache: ApiCacheProtocol {

    internal var wrapped = NSCache<WrappedKey, WrappedValue>()
    internal let dateProvider: ()->Date
    internal let entryLifeTime: TimeInterval
    let persistProvider: ApiCachePersistProviderProtocol?

    init(dateProvider: @escaping ()->Date = { return Date() }, entryLifeTime: TimeInterval = 60*60, maximumEntryCount: Int = 100, persistProvider: ApiCachePersistProviderProtocol? = nil ) {
        self.dateProvider = dateProvider
        self.entryLifeTime = entryLifeTime
        self.persistProvider = persistProvider

        wrapped.countLimit = maximumEntryCount

        inflateMemCache()
    }

    private func inflateMemCache() {
        guard let persistedCache = persistProvider?.cache() else {
            return
        }

        persistedCache.forEach { (key, value) in
            let expirationDate = value.age.addingTimeInterval(entryLifeTime)
            wrapped.setObject(WrappedValue(value: value, expirationDate: expirationDate), forKey: WrappedKey(key: key))
        }
    }

    // MARK: - API

    func insert(value: Data, forKey key: URL) {
        let expirationDate = dateProvider().addingTimeInterval(entryLifeTime)
        let value = Cache(value: value)
        let wrappedValue = WrappedValue(value: value, expirationDate: expirationDate)
        wrapped.setObject(wrappedValue, forKey: WrappedKey(key: key))

        persistProvider?.insertValue(value, forKey: key)
    }

    func value(forKey key: URL, cachePolicy: CachePolicy = .normal) -> (source: Source, data: Data)? {
        switch cachePolicy {

        case .force:
            if let entry = wrapped.object(forKey: WrappedKey(key: key)) {
                return (source: .memCache(age: entry.value.age), data: entry.value.data)
            } else {
                guard let value = persistProvider?.getValueForKey(key) else {
                    return nil
                }

                return (source: .persistedCache(age: value.age), data: value.data)
            }

        case .normal:
            guard let entry = wrapped.object(forKey: WrappedKey(key: key)) else {
                return nil
            }

            guard dateProvider() < entry.expirationDate else {
                removeValue(forKey: key)
                return nil
            }

            return (source: .memCache(age: entry.value.age), data: entry.value.data)
        }
    }

    func removeValue(forKey key: URL) {
        wrapped.removeObject(forKey: WrappedKey(key: key))
    }

}
