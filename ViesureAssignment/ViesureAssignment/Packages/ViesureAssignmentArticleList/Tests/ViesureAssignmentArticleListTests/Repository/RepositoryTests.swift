import XCTest
@testable import ViesureAssignmentArticleList
@testable import ViesureAssignmentCommon
import Combine

final class RepositoryTests: XCTestCase {
    func testArticleRepository() throws {
        var cancellable: Set<AnyCancellable> = []
        let articleRepository = ArticleRepository()
        URLProtocol.registerClass(URLProtocolMock.self)
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolMock.self]
        let expectation = XCTestExpectation(description: "dfasf")
        
        guard let url = Bundle.module.url(forResource: "data", withExtension: "json") else {
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
        
        guard let url = Bundle.module.url(forResource: "data", withExtension: "json") else {
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

    static var allTests = [
        ("testArticleRepository", testArticleRepository),
        ("testFailingArticleRepository", testFailingArticleRepository),
    ]
}
