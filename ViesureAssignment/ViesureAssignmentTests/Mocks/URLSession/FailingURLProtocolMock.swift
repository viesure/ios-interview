//
//  FailingURLProtocolMock.swift
//  ViesureAssignmentTests
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

class FailingURLProtocolMock: URLProtocol {
    
    static var count = 3
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        if FailingURLProtocolMock.count == 0 {
            guard let url = Bundle.main.url(forResource: "data", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else {
                return
            }

            self.client?.urlProtocol(self, didReceive: HTTPURLResponse(url: URL(string: "https://run.mocky.io/v3/de42e6d9-2d03-40e2-a426-8953c7c94fb8")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!, cacheStoragePolicy: .notAllowed)
            self.client?.urlProtocol(self, didLoad: data)
            self.client?.urlProtocolDidFinishLoading(self)
        } else {
            self.client?.urlProtocol(self, didReceive: HTTPURLResponse(url: URL(string: "https://run.mocky.io/v3/de42e6d9-2d03-40e2-a426-8953c7c94fb8")!, statusCode: 500, httpVersion: "HTTP/1.1", headerFields: nil)!, cacheStoragePolicy: .notAllowed)
            
            self.client?.urlProtocolDidFinishLoading(self)
        }
        FailingURLProtocolMock.count -= 1
    }
    
    override func stopLoading() {
        
    }
}
