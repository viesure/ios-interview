//
//  VIArticleTest.swift
//  AssignmentTests
//
//  Created by Stefan Andric on 4/3/20.
//  Copyright © 2020 viesure. All rights reserved.
//

import XCTest
@testable import Assignment

class VIArticleTest: XCTestCase {
    var articles: [VIArticle]?
    var article: VIArticle?
    
    let mockHelper = MockHelper()
    
    override func setUp() {
        super.setUp()
        
        article = try? mockHelper.decoder.decode(VIArticle.self, from: mockHelper.articleData)
        articles = try? mockHelper.decoder.decode([VIArticle].self, from: mockHelper.articlesData)
    }
    
    func testArticleParsing() {
        XCTAssertNotNil(article)
    }
    
    func testArticleArrayParsing() {
        XCTAssertNotNil(articles)
        XCTAssert(articles?.count == 60)
    }
}
