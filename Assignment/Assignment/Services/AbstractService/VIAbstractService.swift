//
//  VIAbstractService.swift
//  Assignment
//
//  Created by Stefan Andric on 4/2/20.
//  Copyright © 2020 viesure. All rights reserved.
//

import Foundation

class VIAbstractService {
    let baseURL = URL(string: "http://viesure.free.beeceptor.com/")!
    var session: URLSession
    
    init() {
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func createRequest(path: String) -> URLRequest {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        urlComponents?.path = path
        
        let urlRequest = URLRequest(url: urlComponents?.url ?? baseURL)
        
        return urlRequest
    }
}
