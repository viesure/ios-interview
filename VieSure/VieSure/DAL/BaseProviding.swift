//
//  BaseProviding.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation

enum CacheStrategy {
    // There is no cache usage at all
    case useBackendOnly
    /*
     - Valid cache is returned without reaching to network else it goes to network
     */
    case useValidCache
    /*
     - Valid cache is returned without reaching to network else it goes to network
     - If network fetch fails force cache is returned if any
     */
    case useValidCacheWithForceCacheOnError
}

enum ProviderResult<Result: Codable> {
    struct Data {
        let result: Result
        let source: Source
    }

    case success(data: Data)
    case error(error: Error)
    case errorWithCache(error: Error, cache: Data)
}

protocol BaseProviding: class {
    var networkConnector: NetworkConnectorProtocol { get }
    var apiCache: ApiCacheProtocol { get }
}

extension BaseProviding {

    func fetch<T: Codable>(url: URL, cacheStrategy: CacheStrategy, completion: @escaping (ProviderResult<T>)->Void) {
        switch cacheStrategy {
        case .useBackendOnly:
            break

        case .useValidCache, .useValidCacheWithForceCacheOnError:
            if let apiCache = apiCache.value(forKey: url, cachePolicy: .normal) {
                cast(data: apiCache.data, source: apiCache.source, error: nil, completion: completion)

                return
            }
        }

        networkConnector.requestFromUrl(url) { [weak self] (result) in
            guard let self = self else {
                completion(.error(error: NetworkError.selfNil))
                return
            }

            switch result {
            case .success(let data):
                switch cacheStrategy {
                case .useValidCache, .useValidCacheWithForceCacheOnError:
                    self.apiCache.insert(value: data, forKey: url)

                default:
                    break
                }

                self.cast(data: data, source: .backend(age: Date()), error: nil, completion: completion)

            case .failure(let error):
                if cacheStrategy == .useValidCacheWithForceCacheOnError, let cache = self.apiCache.value(forKey: url, cachePolicy: .force) {
                    self.cast(data: cache.data, source: cache.source, error: error, completion: completion)
                } else {
                    completion(.error(error: error))
                }
            }
        }
    }

    private func cast<T: Codable>(data: Data, source: Source, error: Error?, completion: @escaping (ProviderResult<T>)->Void) {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.vieSureDateFormatter)
            let obj = try decoder.decode(T.self, from: data)
            let resultData = ProviderResult<T>.Data(result: obj, source: source)

            if let error = error {
                completion(.errorWithCache(error: error, cache: resultData))
            } else {
                completion(.success(data: resultData))
            }
        } catch let error {
            completion(.error(error: error))
        }
    }

}
