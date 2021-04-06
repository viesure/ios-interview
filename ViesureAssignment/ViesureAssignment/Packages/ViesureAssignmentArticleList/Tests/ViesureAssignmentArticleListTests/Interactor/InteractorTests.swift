import XCTest
@testable import ViesureAssignmentArticleList
@testable import ViesureAssignmentCommon
import Combine

final class InteractorTests: XCTestCase {
    func testArticleListInteractor() {
        let store = AppStore()
        let articleRepository = ArticleRepositoryMock()
        let encryptionWorker = EncryptionWorkerMock()
        let fileWriterWorker = FileWriterWorkerMock()
        let articleDateFilterWorker = ArticleDateFilterWorker()
        var cancellableBag: Set<AnyCancellable> = []
        let expectation = XCTestExpectation(description: "set articles app state")
        let expectation2 = XCTestExpectation(description: "set articles viewmodel")
        
        let interactor = ArticleListInteractor(store: store,
                                           articleRepository: articleRepository,
                                           encryptionWorker: encryptionWorker,
                                           fileWriterWorker: fileWriterWorker,
                                           articleDateFilterWorker: articleDateFilterWorker)
        
        interactor.fetchArticles()
        
        let article = ArticleMockFactory.mock()
        
        store.$appState.sink { appState in
            XCTAssertTrue(appState.articles.first?.id == article.id)
            XCTAssertTrue(appState.articles.first?.title == article.title)
            XCTAssertTrue(appState.articles.first?.description == article.description)
            XCTAssertTrue(appState.articles.first?.image == article.image)
            XCTAssertTrue(appState.articles.first?.release_date == article.release_date)
            XCTAssertTrue(appState.articles.first?.author == article.author)
            expectation.fulfill()
        }.store(in: &cancellableBag)
        
        store.$viewModels.sink { viewModels in
            XCTAssertTrue(viewModels.articles.first?.id == article.id)
            XCTAssertTrue(viewModels.articles.first?.title == article.title)
            XCTAssertTrue(viewModels.articles.first?.description == article.description)
            XCTAssertTrue(viewModels.articles.first?.image == URL(string: article.image))
            expectation2.fulfill()
        }.store(in: &cancellableBag)
        
        wait(for: [expectation, expectation2], timeout: 10.0)
    }

    static var allTests = [
        ("testArticleListInteractor", testArticleListInteractor),
    ]
}
