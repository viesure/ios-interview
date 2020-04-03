//
//  ArticleModelTests.swift
//  ArticleModelTests
//
//  Created by Nikola Malinovic on 31.03.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import XCTest
@testable import ArticleModel

class ArticleModelTests: XCTestCase {
    
    var article: Article?
    
    override func setUp() {
        super.setUp()
        article = Article(id: 1,
                          title: "String",
                          articleDescription: "String",
                          author: "String",
                          releaseDate: "String",
                          image: URL(fileURLWithPath: "String"))
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testArticlesModelNotNil() {
        XCTAssertNotNil(article?.id)
        XCTAssertNotNil(article?.title)
        XCTAssertNotNil(article?.articleDescription)
        XCTAssertNotNil(article?.author)
        XCTAssertNotNil(article?.releaseDate)
        XCTAssertNotNil(article?.image)
    }
    
    func testArticlesModelWrongValues() {
        let article2 = Article(id: 3,
                               title: "Realigned multimedia framework",
                               articleDescription: "nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vitae mattis nibh ligula",
                               author: "sfolley0@nhs.uk",
                               releaseDate: "6/25/2018",
                               image: URL(fileURLWithPath: "http://dummyimage.com/366x582.png/5fa2dd/ffffff"))
        
        XCTAssertNotEqual(article?.id, article2.id)
        XCTAssertNotEqual(article?.title, article2.title)
        XCTAssertNotEqual(article?.articleDescription, article2.articleDescription)
        XCTAssertNotEqual(article?.author, article2.author)
        XCTAssertNotEqual(article?.releaseDate, article2.releaseDate)
        XCTAssertNotEqual(article?.image, article2.image)
    }
}
