//
//  TestUserDefaultsPersistProvider.swift
//  VieSureTests
//
//  Created by Papp Balázs on 2020. 05. 13..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
@testable import VieSure

class TestUserDefaultsPersistProvider: ApiCachePersistProviderProtocol {

    let providerName: String = "TestUserDefaultsPersistProvider"
    var maxAge: Double = 0.0
    var storage: Dictionary<URL, Cache> = [:]

    func insertValue(_ value: Cache, forKey key: URL) {
        storage[key] = value
    }

    func getValueForKey(_ key: URL) -> Cache? {
        return storage[key]
    }

    func cache() -> Dictionary<URL, Cache>? {
        return storage
    }

}
