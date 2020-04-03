//
//  ArticleService.swift
//  ArticleServiceModule
//
//  Created by Nikola Malinovic on 01.04.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import ArticleModel
import CommonModule
import Foundation
import NetworkingModule

public protocol ArticleService {
    func getArticles(completion: @escaping (Result<ArticleCall.ReturnType, Error>) -> Void)
}

public class ArticleServiceImpl: ArticleService {
    public let baseURL: URL
    private let userDefaults = SharedUserDefaults()
    
    public init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    public func getArticles(completion: @escaping (Result<ArticleCall.ReturnType, Error>) -> Void) {
        APIClient.start(call: ArticleCall(), baseURL: baseURL, headers: nil, isOffline: false) { result in
            switch result {
            case .success(let articles):
                self.persistToDisc(articles: articles)
                completion(.success(articles))
            case .failure(let error):
                let persistedArticles = self.userDefaults.hasValue(forKey: String(describing: Article.self))
                if persistedArticles {
                    let articles = self.userDefaults.readValueForKey(key: String(describing: Article.self))
                    completion(.success(articles))
                    return
                }
                completion(.failure(error))
            }
        }
    }
    
    public func persistToDisc(articles: ArticleCall.ReturnType) {
        do {
            let jsonData = try JSONEncoder().encode(articles)
            userDefaults.articlesData = jsonData
        } catch {
            #if DEBUG
            print("Couldn't write file")
            #endif
        }
    }
}

public class ArticleOfflineImpl: ArticleService {
    
    public init() { }
    
    public func getArticles(completion: @escaping (Result<ArticleCall.ReturnType, Error>) -> Void) {
        if let path = Bundle(for: APIClient.self).path(forResource: "Articles", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let articles = try JSONDecoder().decode(ArticleCall.ReturnType.self, from: data)
                completion(.success(articles))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}
