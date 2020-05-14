//
//  DetailViewTest.swift
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

        init(expectation: XCTestExpectation) {
            self.expectation = expectation
        }

        func display(viewContent: ArticleDetailViewContent, warning: String?) {
            expectation?.fulfill()
        }

        func display(error: String) {
            expectation?.fulfill()
        }

    }

    var view: TestView!
    var presenter: ArticleDetailPresenter!

    override func setUp() {
        view = TestView(expectation: expectation(description: "view"))
        presenter = ArticleDetailPresenter(view: view, articleProvider: TestArticleProvider(networkConnector: <#NetworkConnectorProtocol#>, apiCache: <#ApiCacheProtocol#>), articleId: 1)

    }

}
