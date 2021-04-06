import XCTest
@testable import ViesureAssignmentCommon

final class WorkerTests: XCTestCase {
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

    static var allTests = [
        ("testFileWriterWorker", testFileWriterWorker),
        ("testEncryptionWorker", testEncryptionWorker),
        ("testEncryptionWorkerAlgo", testEncryptionWorkerAlgo),
    ]
}
