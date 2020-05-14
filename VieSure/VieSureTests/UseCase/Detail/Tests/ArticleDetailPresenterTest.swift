//
//  ArticleDetailPresenterTest.swift
//  VieSureTests
//
//  Created by Papp Balázs on 2020. 05. 13..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import XCTest
@testable import VieSure

class ArticleDetailPresenterTest: XCTestCase {

    class TestView: ArticleDetailViewControlling {
        var expectation: XCTestExpectation?
        var viewContent: ArticleDetailViewContent?
        var warning: String?
        var error: String?

        init(expectation: XCTestExpectation) {
            self.expectation = expectation
        }

        func display(viewContent: ArticleDetailViewContent, warning: String?) {
            self.viewContent = viewContent
            self.warning = warning
            expectation?.fulfill()
        }

        func display(error: String) {
            self.error = error
            expectation?.fulfill()
        }

    }

    var view: TestView!
    var presenter: ArticleDetailPresenter!
    var articleProvider: TestArticleProvider!

    override func setUp() {
        view = TestView(expectation: expectation(description: "view"))
        articleProvider = TestProviderFactory.articleProvider() as? TestArticleProvider
        presenter = ArticleDetailPresenter(view: view, articleProvider: articleProvider, articleId: 1)
    }

    func test_successContent() {
        articleProvider.result = .success(data: .init(result: TestArticleProvider.articles()!.articles, source: .backend(age: Date())))
        presenter.didLoad()

        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
            XCTAssertNotNil(self.view.viewContent)
            XCTAssertEqual(self.view.viewContent!.title, "Realigned multimedia framework")
        }
    }

    func test_cacheSuccessContentOnError() {
        articleProvider.result = .errorWithCache(error: NetworkError.noInternet, cache: .init(result: TestArticleProvider.articles()!.articles, source: .persistedCache(age: Date())))
        presenter.didLoad()

        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
            XCTAssertNotNil(self.view.viewContent)
            XCTAssertNil(self.view.error)
            XCTAssertNotNil(self.view.warning)
            XCTAssertTrue(self.view.warning!.contains("Error happened: noInternet"))
            XCTAssertEqual(self.view.viewContent!.title, "Realigned multimedia framework")
        }
    }

    func test_noArticleForId() {
        articleProvider.result = .success(data: .init(result: [], source: .backend(age: Date())))
        presenter.didLoad()

        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
            XCTAssertNil(self.view.viewContent)
            XCTAssertNil(self.view.warning)
            XCTAssertNotNil(self.view.error)
            XCTAssertEqual(self.view.error!, "There is no article for the Id")
        }
    }

    func test_errorContent() {
        articleProvider.result = .error(error: NetworkError.noInternet)
        presenter.didLoad()

        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
            XCTAssertNil(self.view.viewContent)
            XCTAssertNotNil(self.view.error)
            XCTAssertNil(self.view.warning)
        }
    }

}
