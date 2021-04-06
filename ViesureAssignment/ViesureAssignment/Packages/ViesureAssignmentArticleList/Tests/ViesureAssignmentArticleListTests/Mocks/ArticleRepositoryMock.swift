//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 06.04.21.
//

import UIKit
import ViesureAssignmentArticleList
import ViesureAssignmentCommon
import Combine

class ArticleRepositoryMock: ArticleRepositoryProtocol {
    func get(configuration: URLSessionConfiguration) -> AnyPublisher<[Article], Error> {
        let article = ArticleMockFactory.mock()
        return Future<[Article], Error> { completion in
            completion(.success([article]))
        }.eraseToAnyPublisher()
    }
}
