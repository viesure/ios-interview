//
//  ArticlesInteractor.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import Combine
import ViesureAssignmentCommon

public final class ArticleListInteractor: ArticleListInteractorProtocol {
    public var store: AppStore
    public var articleRepository: ArticleRepositoryProtocol
    public var encryptionWorker: EncryptionWorkerProtocol
    public var fileWriterWorker: FileWriterWorkerProtocol
    public var articleDateFilterWorker: ArticleDateFilterWorkerProtocol
    private var cancellableBag: Set<AnyCancellable> = []
    
    public init(store: AppStore,
         articleRepository: ArticleRepositoryProtocol,
         encryptionWorker: EncryptionWorkerProtocol,
         fileWriterWorker: FileWriterWorkerProtocol,
         articleDateFilterWorker: ArticleDateFilterWorkerProtocol) {
        
        self.store = store
        self.articleRepository = articleRepository
        self.encryptionWorker = encryptionWorker
        self.fileWriterWorker = fileWriterWorker
        self.articleDateFilterWorker = articleDateFilterWorker
    }
    
    public func fetchArticles() {
        articleRepository.get(configuration: URLSessionConfiguration.default)
            .sink { completion in
                switch completion {
                case .failure:
                    let articles = self.loadArticles()
                    let filteredArticles = self.articleDateFilterWorker.applyDateFilter(articles: articles)
                    self.store.appState.articles = filteredArticles
                    self.store.viewModels.articles = filteredArticles.map({ ArticleListViewModel(article: $0) })
                    self.store.errors.articleFetchFailure = true
                case .finished:
                    break
                }
            } receiveValue: { articles in
                let filteredArticles = self.articleDateFilterWorker.applyDateFilter(articles: articles)
                self.store.appState.articles = filteredArticles
                self.store.viewModels.articles = filteredArticles.map({ ArticleListViewModel(article: $0) })
                self.saveArticles(filteredArticles)
            }
            .store(in: &cancellableBag)
    }
    
    public func resetErrors() {
        self.store.errors.articleFetchFailure = false
    }
    
    // MARK: Encrypted Data Persistence
    
    private func saveArticles(_ articles: [Article]) {
        let articlesJSONData = try? JSONEncoder().encode(articles)
        let encryptedArticlesJSONData = encryptionWorker.encrypt(data: articlesJSONData!, fixedIvBytes: nil)
        try? fileWriterWorker.write(data: encryptedArticlesJSONData)
    }

    private func loadArticles() -> [Article] {
        guard let data = try? fileWriterWorker.retrieve(),
              let articles = try? JSONDecoder().decode([Article].self, from: encryptionWorker.decrypt(data: data)) else {
            return []
        }
        return articles
    }
}
