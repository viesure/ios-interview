//
//  ApiCacheTest.swift
//  VieSureTests
//
//  Created by Papp Balázs on 2020. 05. 13..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import XCTest
@testable import VieSure

class ApiCacheTest: XCTestCase {

    var persistProvider: TestUserDefaultsPersistProvider!
    var apiCache: ApiCache!
    var key: URL!

    override func setUp() {
        key = URL(string: "key")!
        persistProvider = TestUserDefaultsPersistProvider()
    }

    func testThereIsValidMemCache() {
        let entryLifeTime: Double = 2

        apiCache = ApiCache(entryLifeTime: entryLifeTime, maximumEntryCount: 10, persistProvider: persistProvider)
        apiCache.insert(value: .init(), forKey: key)

        let cache = self.apiCache.value(forKey: self.key, cachePolicy: .normal)
        XCTAssertNotNil(cache)
        let source = cache!.source.stringRepresentation()
        let memeCacheSource = Source.memCache(age: Date()).stringRepresentation()
        XCTAssertTrue(source == memeCacheSource)
    }

    func testThereIsNoValidMemCache() {
        let nonValidMemCacheExpectation = expectation(description: "testThereIsNoValidMemCache")
        let entryLifeTime: Double = 1

        apiCache = ApiCache(entryLifeTime: entryLifeTime, maximumEntryCount: 10, persistProvider: persistProvider)
        apiCache.insert(value: .init(), forKey: key)

        let delay = entryLifeTime + 1
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            nonValidMemCacheExpectation.fulfill()
        }

        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
            let cache = self.apiCache.value(forKey: self.key, cachePolicy: .normal)
            XCTAssertNil(cache)
        }
    }

    func test_thereIsPersistedCache() {
        let testThereIsMemCache = expectation(description: "testThereIsMemCache")
        let entryLifeTime: Double = 1

        apiCache = ApiCache(entryLifeTime: entryLifeTime, maximumEntryCount: 10, persistProvider: persistProvider)
        apiCache.insert(value: Data(), forKey: key)

        let delay = entryLifeTime + 1
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            testThereIsMemCache.fulfill()
        }

        waitForExpectations(timeout: delay) { error in
            XCTAssertNil(error)

            let memCache = self.apiCache.value(forKey: self.key, cachePolicy: .normal)
            XCTAssertNil(memCache)

            let peristedCache = self.apiCache.value(forKey: self.key, cachePolicy: .force)
            XCTAssertNotNil(peristedCache)

            switch peristedCache!.source {
            case .persistedCache(_):
                break
            default:
                XCTFail("Wrong source")
            }
        }
    }

    func test_inflateMemCache() {
        let testInflatedCacheExpecation = expectation(description: "testInflatedCacheExpecation")
        persistProvider.insertValue(.init(value: .init()), forKey: key)

        apiCache = ApiCache(entryLifeTime: 1, maximumEntryCount: 10, persistProvider: persistProvider)

        let cache = self.apiCache.value(forKey: self.key, cachePolicy: .normal)
        let source = cache!.source.stringRepresentation()
        let memeCacheSource = Source.memCache(age: Date()).stringRepresentation()

        testInflatedCacheExpecation.fulfill()

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertNotNil(cache)
            XCTAssertEqual(source, memeCacheSource)
        }
    }

}
