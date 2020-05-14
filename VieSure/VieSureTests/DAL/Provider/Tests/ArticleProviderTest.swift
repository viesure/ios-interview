//
//  ArticleProviderTest.swift
//  VieSureTests
//
//  Created by Papp Balázs on 2020. 05. 13..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import XCTest
@testable import VieSure

class ArticleProviderTest: XCTestCase {

    var persistProvider: TestUserDefaultsPersistProvider!
    var apiCache: TestApiCache!
    var networkConnector: TestNetworkConnector!
    var articleProvider: ArticleProvider!
    var result: ProviderResult<[Article]>?

    override func setUp() {
        persistProvider = TestUserDefaultsPersistProvider()
        apiCache = TestApiCache(entryLifeTime: 2, maximumEntryCount: 10, persistProvider: persistProvider)
        networkConnector = TestNetworkConnector()
        articleProvider = ArticleProvider(networkConnector: networkConnector, apiCache: apiCache)
    }

    func test_success() {
        let expecation = expectation(description: "test_success")
        networkConnector.result = .success(TestArticleProvider.articles()!.data)
        articleProvider.fetchArticles(cacheStrategy: .useBackendOnly) { (result) in
            self.result = result
            expecation.fulfill()
        }

        waitForExpectations(timeout: 3) { error in
            XCTAssertNil(error)

            switch self.result {
            case .success(let data):
                XCTAssertTrue(data.source.stringRepresentation() == Source.backend(age: Date()).stringRepresentation())
                XCTAssertEqual(data.result.first!.title, "Realigned multimedia framework")

            default:
                XCTFail("Should not enter to default")
            }
        }
    }

    func test_errorNoInternet() {
        let expect = expectation(description: "test_errorNoInternet")
        networkConnector.result = .failure(NetworkError.noInternet)
        articleProvider.fetchArticles(cacheStrategy: .useBackendOnly) { (result) in
            self.result = result
            expect.fulfill()
        }

        waitForExpectations(timeout: 3) { error in
            XCTAssertNil(error)

            switch self.result {
            case .error(let error):
                XCTAssertTrue(error as? NetworkError == NetworkError.noInternet)

            default:
                XCTFail("Should not enter to default")
            }
        }
    }

    func test_errorParse() {
        let expect = expectation(description: "test_errorParse")
        networkConnector.result = .success(.init())
        articleProvider.fetchArticles(cacheStrategy: .useValidCache) { result in
            self.result = result
            expect.fulfill()
        }

        waitForExpectations(timeout: 3) { error in
            XCTAssertNil(error)

            switch self.result {
            case .error(let error):
                XCTAssertNotNil(error as? DecodingError)

            default:
                XCTFail("Should not enter to default")
            }
        }
    }

    func test_errorWithCache() {
        let expect = expectation(description: "test_errorWithCace")
        let key = URL(string: "http://viesure.free.beeceptor.com/articles")!

        apiCache.insert(value: TestArticleProvider.articles()!.data, forKey: key)
        apiCache.source = .persistedCache(age: Date())
        networkConnector.result = .failure(NetworkError.unknown)

        articleProvider.fetchArticles(cacheStrategy: .useValidCacheWithForceCacheOnError) { result in
            self.result = result
            expect.fulfill()
        }

        waitForExpectations(timeout: 3) { error in
            XCTAssertNil(error)

            switch self.result {
            case .errorWithCache(let error, let cache):
                XCTAssertEqual(error as! NetworkError, NetworkError.unknown)
                switch cache.source {
                case .persistedCache(let age):
                    XCTAssertEqual(age.dateDiffInMinutes(), "0 minute")
                    break
                default:
                    XCTFail("Source should be .persistedCache")
                }
                XCTAssertEqual(cache.result.first?.id, 1)
                XCTAssertEqual(cache.result.first?.title, "Realigned multimedia framework")
                XCTAssertEqual(cache.result.first?.releaseDate.prettyDate(), "Mon, Jun 25, '18")
            default:
                XCTFail("Should not enter to default")
            }
        }

    }



}
