//
//  Call.swift
//  NetworkingModule
//
//  Created by Nikola Malinovic on 31.03.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

public enum ContentType: String {
    case applicationJSON = "application/json"
}

public typealias Parameters = [String: String]

public protocol Call {
    associatedtype ReturnType: Decodable
    //    associatedtype EncodableType: Encodable
    
    //    var encodableBody: EncodableType? { get }
    var body: Data? { get }
    var contentType: ContentType { get }
    var method: Method { get }
    var parameters: Parameters? { get }
    var path: String { get }
    
    func decode(_ data: Data) throws -> ReturnType
}

public protocol EmptyObject: Encodable { }

public extension Call {
    
    var body: Data? { return nil }
    var contentType: ContentType { return .applicationJSON }
    //    var encodableBody: EncodableType? { return nil }
    var parameters: Parameters? { return nil }
    var method: Method { return .get }
    
    func request(fromBaseURL url: URL?) throws -> URLRequest {
        guard let baseURL = url else {
            #if DEBUG
            print("request(fromBaseURL NIL")
            #endif
            throw APIError.baseURLNil
        }
        
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path),
                                             resolvingAgainstBaseURL: false) else {
                                                #if DEBUG
                                                print("Components nil")
                                                #endif
                                                throw APIError.baseURLNil
        }
        components.queryItems = parameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let finalURL = components.url else {
            #if DEBUG
            print("finalURL nil")
            #endif
            throw APIError.baseURLNil
        }
        
        var request = URLRequest(url: finalURL)
        request.httpBody = body
        //        request.httpBody = try? encode(encodableBody)
        request.httpMethod = method.rawValue
        request.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        
        #if DEBUG
        print(request.allHTTPHeaderFields?.description ?? "")
        if let body = body {
            print("BODY>>>")
            print(String(data: body, encoding: String.Encoding.utf8) ?? "")
        }
        #endif
        
        return request
    }
    
    func decode(_ data: Data) throws -> ReturnType {
        return try JSONDecoder().decode(ReturnType.self, from: data)
    }
    
    //    func encode<E: Encodable>(_ encodable: E?) throws -> Data? {
    //        return try JSONEncoder().encode(encodable)
    //    }
    
    var offlineData: Data? {
        let resource = Bundle(for: NetworkingClass.self).path(forResource: "Articles", ofType: "json")
        guard resource != nil else {
            // Failing fatally here because the print output is cleared during test execution and nobody would notice it
            fatalError("No offlineData was set for \(Self.self), create a \(Self.self).json in the appropriate service module!")
        }
        if let path = resource {
            return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        }
        #if DEBUG
        print("ERROR>>> NO FILE \(Self.self).json FOUND, create it!")
        #endif
        return nil
    }
}

class NetworkingClass { }
