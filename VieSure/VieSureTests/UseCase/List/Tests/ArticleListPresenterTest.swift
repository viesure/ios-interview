//
//  ArticleListPresenterTest.swift
//  VieSureTests
//
//  Created by Papp Balázs on 2020. 05. 13..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import XCTest
@testable import VieSure

class ArticleListPresenterTest: XCTestCase {

    class TestView: ArticleListViewControlling {

        var expectation: XCTestExpectation?
        var viewContent: ArticleListViewContent?
        var warning: String?
        var error: String?

        init(expectation: XCTestExpectation) {
            self.expectation = expectation
        }

        func display(viewContent: ArticleListViewContent, warning: String?) {
            self.viewContent = viewContent
            self.warning = warning
            expectation?.fulfill()
        }

        func openDetail(viewController: ArticleDetailViewController) {
            expectation?.fulfill()
        }

        func display(error: String) {
            self.error = error
            expectation?.fulfill()
        }

    }

    var view: TestView!
    var presenter: ArticleListPresenter!
    var articleProvider: TestArticleProvider!

    override func setUp() {
        view = TestView(expectation: expectation(description: "view"))
        articleProvider = TestProviderFactory.articleProvider()
        presenter = ArticleListPresenter(view: view, articleProvider: articleProvider)
    }

    func test_successContent() {
        articleProvider.result = .success(data: .init(result: TestArticleProvider.articles()!.articles, source: .backend(age: Date())))
        presenter.didLoad()

        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
            XCTAssertNotNil(self.view.viewContent)
            XCTAssertEqual(self.view.viewContent!.rows.first!.articleTitle, "Versatile 6th generation definition")
        }
    }

    func test_openDetail() {
         articleProvider.result = .success(data: .init(result: TestArticleProvider.articles()!.articles, source: .backend(age: Date())))

         presenter.didLoad()

         waitForExpectations(timeout: 5) { error in
             XCTAssertNil(error)
             XCTAssertNotNil(self.view.viewContent)

            self.view.expectation = self.expectation(description: "openDetail")
            self.view.viewContent?.rows.first?.onClick()

            self.waitForExpectations(timeout: 5) { error in
                XCTAssertNil(error)
            }

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
            XCTAssertEqual(self.view.viewContent!.rows.first!.articleTitle, "Versatile 6th generation definition")
        }
    }

    func test_noArticles() {
        articleProvider.result = .success(data: .init(result: [], source: .backend(age: Date())))
        presenter.didLoad()

        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
            XCTAssertNotNil(self.view.viewContent)
            XCTAssertTrue(self.view.viewContent!.rows.count == 0)
            XCTAssertNil(self.view.warning)
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
