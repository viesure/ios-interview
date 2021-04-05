//
//  WorkerTests.swift
//  ViesureAssignmentTests
//
//  Created by Kurt Jacobs on 04.04.21.
//

import XCTest
import Combine
@testable import ViesureAssignment

class WorkerTests: XCTestCase {
    func testFileWriterWorker() throws {
        let fileWriterWorker = FileWriterWorker()
        let article = ArticleMockFactory.mock()
        
        let articleData = try JSONEncoder().encode(article)
        try fileWriterWorker.write(data: articleData)
        let loadedData = try fileWriterWorker.retrieve()
        let articleLoaded = try JSONDecoder().decode(Article.self, from: loadedData)
        
        XCTAssertTrue(article.id == articleLoaded.id)
        XCTAssertTrue(article.author == articleLoaded.author)
        XCTAssertTrue(article.description == articleLoaded.description)
        XCTAssertTrue(article.title == articleLoaded.title)
        XCTAssertTrue(article.image == articleLoaded.image)
        XCTAssertTrue(article.release_date == articleLoaded.release_date)
    }
    
    func testEncryptionWorker() throws {
        let encryptionWorker = EncryptionWorker()
        let article = ArticleMockFactory.mock()
        let articleData = try JSONEncoder().encode(article)
        
        let encryptedData = encryptionWorker.encrypt(data: articleData)
        let decryptedData = encryptionWorker.decrypt(data: encryptedData)
        
        let articleLoaded = try JSONDecoder().decode(Article.self, from: decryptedData)
        
        XCTAssertTrue(article.id == articleLoaded.id)
        XCTAssertTrue(article.author == articleLoaded.author)
        XCTAssertTrue(article.description == articleLoaded.description)
        XCTAssertTrue(article.title == articleLoaded.title)
        XCTAssertTrue(article.image == articleLoaded.image)
        XCTAssertTrue(article.release_date == articleLoaded.release_date)
    }
    
    func testEncryptionWorkerAlgo() {
        let iv: [UInt8] = [65,65,65,66,67,68,69,70,71,72,73,74,75,76,76,87]
        
        let testData = "Hello".data(using: .utf8)!
        let hexStringTestData = testData.reduce("") {$0 + String(format: "%02x", $1)}
        
        let encryptionWorker = EncryptionWorker()
        let encryptedTestData = encryptionWorker.encrypt(data: testData, fixedIvBytes: iv)
        let hexStringEncryptedTestData = encryptedTestData.reduce("") {$0 + String(format: "%02x", $1)}
        
        let decryptedTestData = encryptionWorker.decrypt(data: encryptedTestData)
        let hexStringDecryptedTestData = decryptedTestData.reduce("") {$0 + String(format: "%02x", $1)}
        
        XCTAssertTrue(hexStringTestData == "48656c6c6f")
        XCTAssertTrue(hexStringEncryptedTestData == "41414142434445464748494a4b4c4c57051f76e19cec6c6949dde2bca6ca3522")
        XCTAssertTrue(hexStringDecryptedTestData == "48656c6c6f")
    }
    
    func testArticleDateFilterWorker() {
        let article1 = Article(id: 1, title: "a", description: "a", author: "a", release_date: "12/11/2000", image: "")
        let article2 = Article(id: 2, title: "b", description: "a", author: "a", release_date: "11/11/2000", image: "")
        let article3 = Article(id: 3, title: "c", description: "a", author: "a", release_date: "13/11/2000", image: "")
        
        let articleDateFilterWorker = ArticleDateFilterWorker()
        let filteredArticles = articleDateFilterWorker.applyDateFilter(articles: [article1, article2, article3])
        
        XCTAssertTrue(filteredArticles[0].title == "c")
        XCTAssertTrue(filteredArticles[1].title == "a")
        XCTAssertTrue(filteredArticles[2].title == "b")
        
    }

}
