//
//  UITestingMockTests.swift
//  ViesureAssignmentTests
//
//  Created by Kurt Jacobs on 04.04.21.
//

import XCTest
import Combine
@testable import ViesureAssignment

// These tests are mainly for code coverage because the mocks have to be contained inside of the main application for UI testing. Not so great and would like to think about this a bit more and see how they can be included in the test bundle instead.

class UITestingMockTests: XCTestCase {
    func testrepositoryContainerMock() throws {
        let repositoryMock = RepositoryContainerMock()
        XCTAssertTrue(repositoryMock.articleRepository is ArticleRepositoryMock)
    }
    
    func testArticleRepositoryMock() {
        var cancellable: Set<AnyCancellable> = []
        let articleRepository = ArticleRepositoryMock()
        let expectation = XCTestExpectation(description: "article count")
        
        articleRepository.get(configuration: URLSessionConfiguration.default).sink { complete in
        } receiveValue: { articles in
            XCTAssertTrue(articles.count == 1)
            expectation.fulfill()
        }.store(in: &cancellable)

        wait(for: [expectation], timeout: 10.0)
    }
    
    func testApplicationContainerMock() {
        let applicationContainerMock = ApplicationContainerMock()
    }
}
