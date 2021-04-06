import XCTest
@testable import ViesureAssignmentArticleList
@testable import ViesureAssignmentCommon
import Combine

final class WorkerTests: XCTestCase {
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
    
        static var allTests = [
        ("testArticleDateFilterWorker", testArticleDateFilterWorker),
        ]
}
