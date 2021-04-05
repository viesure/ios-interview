//
//  ArticleDetailInteractor.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

protocol ArticleDetailInteractorProtocol {
    init(store: AppStore)
    func fetchArticle(with identifier: Int)
}

final class ArticleDetailInteractor: ArticleDetailInteractorProtocol {
    var store: AppStore
    
    init(store: AppStore) {
        self.store = store
    }
    
    func fetchArticle(with identifier: Int) {
        let article = store.appState.articles.first { article in
            return article.id == identifier
        }
        guard let articleUnwrapped = article else { return }
        store.viewModels.articleDetail = ArticleDetailViewModel(article: articleUnwrapped)
    }
}
