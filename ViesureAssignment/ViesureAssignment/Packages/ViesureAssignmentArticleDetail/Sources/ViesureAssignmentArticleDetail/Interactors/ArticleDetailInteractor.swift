//
//  ArticleDetailInteractor.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import ViesureAssignmentCommon

public protocol ArticleDetailInteractorProtocol {
    init(store: AppStore)
    func fetchArticle(with identifier: Int)
}

public final class ArticleDetailInteractor: ArticleDetailInteractorProtocol {
    private var store: AppStore
    
    public init(store: AppStore) {
        self.store = store
    }
    
    public func fetchArticle(with identifier: Int) {
        let article = store.appState.articles.first { article in
            return article.id == identifier
        }
        guard let articleUnwrapped = article else { return }
        store.viewModels.articleDetail = ArticleDetailViewModel(article: articleUnwrapped)
    }
}
