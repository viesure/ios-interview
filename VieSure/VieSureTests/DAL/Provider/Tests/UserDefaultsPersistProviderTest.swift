//
//  UserDefaultsPersistProviderTest.swift
//  VieSureTests
//
//  Created by Papp Balázs on 2020. 05. 13..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import XCTest
@testable import VieSure

class UserDefaultsPersistProviderTest: XCTestCase {

    var persistProvider: UserDefaultsPersistProvider!
    var key: URL!
    var maxAge: Double!

    override func setUp() {
        maxAge = 10
        persistProvider = UserDefaultsPersistProvider(providerName: "testProvider", maxAge: maxAge)
        key = URL(string: "key")!
    }

    func test_insertValueGetValue() {
        let cache = Cache(value: Data())
        persistProvider.insertValue(cache, forKey: key)

        let cachedValue = persistProvider.getValueForKey(key)
        XCTAssertNotNil(cachedValue)
        XCTAssertEqual(cachedValue!.data, cache.data)
    }

    func test_returnNilForWrongKey() {
        let cache = Cache(value: Data())
        persistProvider.insertValue(cache, forKey: key)

        let cachedValue = persistProvider.getValueForKey(URL(string: "wrongKey")!)
        XCTAssertNil(cachedValue)
    }

    func test_removeOldValuesToPreventMemoryOverflow() {
        let cache = Cache(value: Data(), age: .distantPast)
        persistProvider.insertValue(cache, forKey: key)

        let cacheDict = persistProvider.cache()
        XCTAssertTrue(cacheDict?.count == 0)
    }

}
