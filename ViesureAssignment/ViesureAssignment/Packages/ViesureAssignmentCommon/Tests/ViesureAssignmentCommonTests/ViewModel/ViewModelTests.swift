import XCTest
@testable import ViesureAssignmentCommon

final class ViewModelTests: XCTestCase {
    func testArticleListViewModel() {
        let article = ArticleMockFactory.mock()
        let articleListViewModel = ArticleListViewModel(article: article)
        
        XCTAssertTrue(articleListViewModel.id == article.id)
        XCTAssertTrue(articleListViewModel.title == article.title)
        XCTAssertTrue(articleListViewModel.description == article.description)
        XCTAssertTrue(articleListViewModel.image == URL(string: article.image))
    }
    
    func testArticleDetailViewModel() {
        let article = ArticleMockFactory.mock()
        let articleDetailViewModel = ArticleDetailViewModel(article: article)
        
        XCTAssertTrue(articleDetailViewModel.id == article.id)
        XCTAssertTrue(articleDetailViewModel.title == article.title)
        XCTAssertTrue(articleDetailViewModel.description == article.description)
        XCTAssertTrue(articleDetailViewModel.image == URL(string: article.image))
        XCTAssertTrue(articleDetailViewModel.release_date == ArticleDetailViewModel.format(dateString: article.release_date))
        XCTAssertTrue(articleDetailViewModel.author == "Author: \(article.author)")
    }
    
    func testArticleDetailViewModelDateFormatting() {
        let formattedDate = ArticleDetailViewModel.format(dateString: "6/25/2018")
        XCTAssertTrue(formattedDate == "Thu, Jan 25, '18")
    }

    static var allTests = [
        ("testArticleListViewModel", testArticleListViewModel),
        ("testArticleDetailViewModel", testArticleDetailViewModel),
        ("testArticleDetailViewModelDateFormatting", testArticleDetailViewModelDateFormatting),
    ]
}
