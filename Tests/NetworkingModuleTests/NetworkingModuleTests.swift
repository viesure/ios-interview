//
//  NetworkingModuleTests.swift
//  NetworkingModuleTests
//
//  Created by Nikola Malinovic on 31.03.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import XCTest
@testable import NetworkingModule
@testable import ArticleServiceModule

class NetworkingModuleTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetArticleCallSuccess() {
        let exp = expectation(description: "Expecting Article Call")
        APIClient.start(call: ArticleCall(),
                        baseURL: URL(string: "http://viesure.free.beeceptor.com/")!,
                        isOffline: false) { loginResult in
                            switch loginResult {
                            case .success(let result):
                                XCTAssertNotNil(result)
                                print(result)
                                exp.fulfill()
                            case .failure(let error):
                                XCTFail("Failure: \(error)")
                            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testGetArticleCallFail() {
        let exp = expectation(description: "Expecting Article Call to fail")
        APIClient.start(call: ArticleCall(),
                        baseURL: URL(string: "http://viesure.free.beeceptor.com/wrongpath")!) { results in
                            switch results {
                            case .success:
                                XCTFail("Failure becaues there are: \(results)")
                            case .failure(let error):
                                XCTAssertNotNil(error)
                                exp.fulfill()
                            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testGetArticleOfflineCall() {
        let exp = expectation(description: "Expecting Article Call to fail")
        APIClient.start(call: ArticleCall(),
                        baseURL: URL(string: "http://viesure.free.beeceptor.com/")!,
                        isOffline: true) { results in
                            switch results {
                            case .success(let result):
                                XCTAssertNotNil(result)
                                print(result)
                                exp.fulfill()
                            case .failure(let error):
                                XCTFail("Failure: \(error)")
                            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testResourceIsNil() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        let exp = expectation(description: "Expecting Article Call to fail")
        APIClient.start(call: ArticleCall(),
                        baseURL: URL(string: "http://viesure.free.beeceptor.com/wrongpath")!,
                        isOffline: false) { results in
                            switch results {
                            case .success:
                                XCTFail("Failure becaues there are: \(results)")
                            case .failure(let error):
                                XCTAssertNotNil(error)
                                exp.fulfill()
                            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testEndPoint() {
        let url = URL(fileURLWithPath: "http://viesure.free.beeceptor.com/")
        let endPoint = Endpoint.init(baseURL: url)
        XCTAssertEqual(url, endPoint.baseURL)
    }
    
    func testMethod() {
        let getMethod = Method.get
        let postMethod = Method.post
        var request = URLRequest(url: URL(fileURLWithPath: "url"))
        request.httpMethod = getMethod.rawValue
        XCTAssertNotNil(request.httpMethod)
        request.httpMethod = nil
        request.httpMethod = postMethod.rawValue
        XCTAssertNotNil(request.httpMethod)
    }
    
    func testApiError() {
        let baseURLNilError = APIError.baseURLNil
        let dataNilError = APIError.dataNil
        let decodingError = APIError.decodingError
        let requestNilError = APIError.requestNil
        
        XCTAssertNotNil(baseURLNilError)
        XCTAssertNotNil(dataNilError)
        XCTAssertNotNil(decodingError)
        XCTAssertNotNil(requestNilError)
    }
}
