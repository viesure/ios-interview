//
//  ArticlesWorker.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import Combine
import ViesureAssignmentCommon

enum ArticleRepositoryHTTPError: Error {
    case internalAppError
    case internalServerError
}

public class ArticleRepository : ArticleRepositoryProtocol {
    var url: String = "https://run.mocky.io/v3/de42e6d9-2d03-40e2-a426-8953c7c94fb8"
    private var timeDelayForErrorInSeconds = 2
    
    public init() {}
    
    public func get(configuration: URLSessionConfiguration) -> AnyPublisher<[Article], Error> {
        let publisher = URLSession(configuration: configuration).dataTaskPublisher(for: URL(string: url)!)
            .receive(on: DispatchQueue.main)
            .mapError({ $0 as Error })
            .map({ response -> AnyPublisher<(data: Data, response: URLResponse), Error> in
                guard let httpResponse = response.response as? HTTPURLResponse else {
                  return Fail(error: ArticleRepositoryHTTPError.internalAppError)
                    .eraseToAnyPublisher()
                }
                
                if httpResponse.statusCode == 500 {
                    return Fail(error: ArticleRepositoryHTTPError.internalServerError)
                        .delay(for: .seconds(self.timeDelayForErrorInSeconds), scheduler: DispatchQueue.global())
                        .eraseToAnyPublisher()
                }

                return Just(response)
                  .setFailureType(to: Error.self)
                  .eraseToAnyPublisher()
            })
            .switchToLatest()
            .eraseToAnyPublisher()
            
            return publisher
                .share()
                .tryCatch({ error -> AnyPublisher<(data: Data, response: URLResponse), Error> in
                    switch error {
                    case ArticleRepositoryHTTPError.internalServerError:
                      return publisher
                    default:
                      throw error
                    }
                })
                .retry(2)
                .map({ $0.data })
                .decode(type: [Article].self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
    }
}
