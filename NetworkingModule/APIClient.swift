//
//  APIClient.swift
//  NetworkingModule
//
//  Created by Nikola Malinovic on 31.03.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import Foundation

public class APIClient {
    public static func start<C: Call>(call: C,
                                      baseURL: URL,
                                      headers: [String: String]? = nil,
                                      isOffline: Bool = false,
                                      result: ((Result<C.ReturnType, Error>) -> Void)?) {
        
        if isOffline, let offlineData = call.offlineData {
            guard let objects = try? call.decode(offlineData) else {
                #if DEBUG
                print("*** Decoding error \(APIError.decodingError.localizedDescription)")
                #endif
                DispatchQueue.main.async {
                    result?(.failure(APIError.decodingError))
                }
                return
            }
            
            DispatchQueue.main.async {
                result?(.success(objects))
            }
            return
        }
        
        guard var request = try? call.request(fromBaseURL: baseURL) else {
            #if DEBUG
            print("*** API Error: \(APIError.requestNil.localizedDescription)")
            #endif
            DispatchQueue.main.async {
                result?(.failure(APIError.requestNil))
            }
            return
        }
        
        request.httpBody = call.body
        
        if let headers = headers {
            headers.forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        #if DEBUG
        print("*** URL >>> \(request.url?.absoluteString ?? "")")
        #endif
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                DispatchQueue.main.async {
                    result?(.failure(APIError.dataNil))
                }
                return
            }
            
            #if DEBUG
            print("*** \(String(data: data, encoding: String.Encoding.utf8) ?? "")" )
            #endif
            
            guard let objects = try? call.decode(data) else {
                #if DEBUG
                print("*** \(APIError.decodingError.localizedDescription)")
                #endif
                
                DispatchQueue.main.async {
                    result?(.failure(APIError.decodingError))
                }
                return
            }
            
            DispatchQueue.main.async {
                result?(.success(objects))
            }
            return
        }.resume()
    }
}
