//
//  ArticleProvider.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation

protocol ArticleProviding {
    func fetchArticles(cacheStrategy: CacheStrategy, completion: @escaping (ProviderResult<[Article]>)->Void)
}

extension ProviderFactory {
    static func articleProvider() -> ArticleProviding {
        return ArticleProvider(networkConnector: NetworkConnector(), apiCache: ObjectContainer.sharedContainer.apiCache)
    }
}

class ArticleProvider: BaseProvider, ArticleProviding {

    func fetchArticles(cacheStrategy: CacheStrategy, completion: @escaping (ProviderResult<[Article]>) -> Void) {
        guard let url = URL(string: "http://viesure.free.beeceptor.com/articles") else {
            completion(.error(error: NetworkError.wrongUrl))
            return
        }

        fetch(url: url, cacheStrategy: cacheStrategy, completion: { (result: ProviderResult<[Article]>) in
            DispatchQueue.main.async {
                completion(result)
            }
        })
    }

}
