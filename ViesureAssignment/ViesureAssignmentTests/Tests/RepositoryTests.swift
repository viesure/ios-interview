//
//  RepositoryTests.swift
//  ViesureAssignmentTests
//
//  Created by Kurt Jacobs on 04.04.21.
//

import XCTest
import Combine
@testable import ViesureAssignment

class RepositoryTests: XCTestCase {
    func testArticleRepository() throws {
        var cancellable: Set<AnyCancellable> = []
        let articleRepository = ArticleRepository()
        URLProtocol.registerClass(URLProtocolMock.self)
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolMock.self]
        let expectation = XCTestExpectation(description: "dfasf")
        
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            XCTFail("Bundle URL Failure")
            return
        }
        let data = try Data(contentsOf: url)
        let articlesDisk = try JSONDecoder().decode([Article].self, from: data)
        
        articleRepository.get(configuration: config)
            .replaceError(with: [])
            .sink { articles in
                XCTAssertTrue(articles == articlesDisk)
                expectation.fulfill()
            }.store(in: &cancellable)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFailingArticleRepository() throws {
        var cancellable: Set<AnyCancellable> = []
        let articleRepository = ArticleRepository()
        URLProtocol.registerClass(FailingURLProtocolMock.self)
        let config = URLSessionConfiguration.default
        config.protocolClasses = [FailingURLProtocolMock.self]
        let expectation = XCTestExpectation(description: "dfasf")
        
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            XCTFail("Bundle URL Failure")
            return
        }
        let data = try Data(contentsOf: url)
        let articlesDisk = try JSONDecoder().decode([Article].self, from: data)
        
        articleRepository.get(configuration: config).sink { completion in
            switch completion {
            case let .failure(error):
                print (error)
                break
            case .finished:
                break
            }
        } receiveValue: { articles in
            XCTAssertTrue(articles == articlesDisk)
            expectation.fulfill()
        }.store(in: &cancellable)

        wait(for: [expectation], timeout: 30.0)
    }

}
