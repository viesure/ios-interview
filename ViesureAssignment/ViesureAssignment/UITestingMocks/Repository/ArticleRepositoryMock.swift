//
//  ArticleRepositoryMock.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import UIKit
import Combine

class ArticleRepositoryMock: ArticleRepositoryProtocol {
    func get(configuration: URLSessionConfiguration) -> AnyPublisher<[Article], Error> {
        let article = ArticleMockFactory.mock()
        return Future<[Article], Error> { completion in
            completion(.success([article]))
        }.eraseToAnyPublisher()
    }
}

class ArticleMockFactory {
    static func mock() -> Article {
        let article = Article(id: 1, title: "This is a title", description: "This is a description", author: "Kurt Jacobs", release_date: "6/25/2018", image: "http://dummyimage.com/366x582.png/5fa2dd/ffffff")
        return article
    }
}
