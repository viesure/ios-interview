//
//  VIStorageTest.swift
//  AssignmentTests
//
//  Created by Stefan Andric on 4/3/20.
//  Copyright © 2020 viesure. All rights reserved.
//

import XCTest
@testable import Assignment

class VIStorageTest: XCTestCase {

    var articles: [VIArticle]?
    var article: VIArticle?
    
    let mockHelper = MockHelper()
    
    override func setUp() {
        super.setUp()
        
        article = try? mockHelper.decoder.decode(VIArticle.self, from: mockHelper.articleData)
        articles = try? mockHelper.decoder.decode([VIArticle].self, from: mockHelper.articlesData)
    }
    
    func testArticleStorage() {
        VIStorage.store(article, to: .documents, as: "article.json")
        
        let articleStored = VIStorage.retrieve("article.json", from: .documents, as: VIArticle.self)
        
        XCTAssertNotNil(articleStored)
    }
    
    func testArticlesStorage() {
        VIStorage.store(articles, to: .documents, as: "articles.json")
        
        let articlesStored = VIStorage.retrieve("articles.json", from: .documents, as: [VIArticle].self)
        
        XCTAssertNotNil(articlesStored)
    }
    
    func testArticlesClearing() {
        VIStorage.clear(.documents)
        
        let articlesExists = VIStorage.fileExists("articles.json", in: .documents)
        let articleExists = VIStorage.fileExists("article.json", in: .documents)
        
        XCTAssert(articlesExists == false)
        XCTAssert(articleExists == false)
    }

}
