//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 06.04.21.
//

import XCTest
@testable import ViesureAssignmentArticleDetail
@testable import ViesureAssignmentCommon
import Combine

final class InteractorTests: XCTestCase {
    func testArticleDetailInteractor() {
        let article = ArticleMockFactory.mock()
        let articles = [article]
        let store = AppStore()
        store.appState.articles = articles
        
        let interactor = ArticleDetailInteractor(store: store)
        var cancellableBag: Set<AnyCancellable> = []
        let expectation = XCTestExpectation(description: "set articles detail viewmodel")
        
        interactor.fetchArticle(with: 1)
        
        store.$viewModels.sink { viewModels in
            XCTAssertTrue(viewModels.articleDetail?.id == article.id)
            XCTAssertTrue(viewModels.articleDetail?.title == article.title)
            XCTAssertTrue(viewModels.articleDetail?.description == article.description)
            XCTAssertTrue(viewModels.articleDetail?.image == URL(string: article.image))
            XCTAssertTrue(viewModels.articleDetail?.release_date == ArticleDetailViewModel.format(dateString: article.release_date))
            XCTAssertTrue(viewModels.articleDetail?.author == "Author: \(article.author)")
            expectation.fulfill()
        }.store(in: &cancellableBag)
        
        wait(for: [expectation], timeout: 10.0)
    }


    static var allTests = [
        ("testArticleDetailInteractor", testArticleDetailInteractor),
    ]
}
