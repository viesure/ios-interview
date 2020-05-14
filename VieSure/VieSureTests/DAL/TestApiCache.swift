//
//  TestApiCache.swift
//  VieSureTests
//
//  Created by Papp Balázs on 2020. 05. 13..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
@testable import VieSure

class TestApiCache: ApiCacheProtocol {

    var wrapped = NSCache<WrappedKey, WrappedValue>()
    let dateProvider: () -> Date
    let entryLifeTime: TimeInterval
    let persistProvider: ApiCachePersistProviderProtocol?

    var source: Source!
    var result: Dictionary<URL, Data> = [:]

    init(dateProvider: @escaping ()->Date = { return Date() }, entryLifeTime: TimeInterval, maximumEntryCount: Int, persistProvider: ApiCachePersistProviderProtocol?) {
        self.dateProvider = dateProvider
        self.entryLifeTime = entryLifeTime
        self.persistProvider = persistProvider

        wrapped.countLimit = maximumEntryCount
    }

    func insert(value: Data, forKey key: URL) {
        result[key] = value
    }

    func value(forKey key: URL, cachePolicy: CachePolicy) -> (source: Source, data: Data)? {
        switch cachePolicy {
        case .normal:
            return nil
        case .force:
            guard let data = result[key] else {
                return nil
            }

            return (source: source, data: data)
        }
    }

    func removeValue(forKey key: URL) {}

}
