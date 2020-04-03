//
//  ArticleServiceModuleTests.swift
//  ArticleServiceModuleTests
//
//  Created by Nikola Malinovic on 01.04.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import XCTest
@testable import ArticleServiceModule

class ArticleServiceModuleTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetArticlesCall() {
        let articlesService = ArticleServiceImpl(baseURL: URL(string: "http://viesure.free.beeceptor.com/")!)
        let exp = expectation(description: "Expecting Article Call not to fail")
        articlesService.getArticles { result in
            switch result {
            case .success(let articles):
                XCTAssertNotNil(articles)
                print(result)
                exp.fulfill()
            case .failure:
                #if DEBUG
                print("ERROR>>> ArticlesController getArticles")
                #endif
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testGetArticlesCallFail() {
        let articlesService = ArticleServiceImpl(baseURL: URL(string: "http://viesure.xxx.com/")!)
        let exp = expectation(description: "Expecting Article Call to fail")
        articlesService.getArticles { results in
            switch results {
            case .success:
                XCTAssertNotNil(results)
                exp.fulfill()
            case .failure(let error):
                XCTFail("Failure becaues there are: \(error)")
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testGetArticlesOfflineCall() {
        let articlesService = ArticleOfflineImpl()
        let exp = expectation(description: "Expecting Article Call not to fail")
        articlesService.getArticles { result in
            switch result {
            case .success(let articles):
                XCTAssertNotNil(articles)
                print(result)
                exp.fulfill()
            case .failure:
                #if DEBUG
                print("ERROR>>> ArticlesController getArticles")
                #endif
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}
