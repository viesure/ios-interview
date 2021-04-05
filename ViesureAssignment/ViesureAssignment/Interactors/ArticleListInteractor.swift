//
//  ArticlesInteractor.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import Combine

protocol ArticleListInteractorProtocol {
    init(store: AppStore,
         articleRepository: ArticleRepositoryProtocol,
         encryptionWorker: EncryptionWorkerProtocol,
         fileWriterWorker: FileWriterWorkerProtocol,
         articleDateFilterWorker: ArticleDateFilterWorkerProtocol)
    
    var store: AppStore { get set }
    var articleRepository: ArticleRepositoryProtocol { get set }
    var encryptionWorker: EncryptionWorkerProtocol { get set }
    var fileWriterWorker: FileWriterWorkerProtocol { get set }
    var articleDateFilterWorker: ArticleDateFilterWorkerProtocol { get set }
    
    func fetchArticles()
    func resetErrors()
}

final class ArticleListInteractor: ArticleListInteractorProtocol {
    var store: AppStore
    var articleRepository: ArticleRepositoryProtocol
    var encryptionWorker: EncryptionWorkerProtocol
    var fileWriterWorker: FileWriterWorkerProtocol
    var articleDateFilterWorker: ArticleDateFilterWorkerProtocol
    var cancellableBag: Set<AnyCancellable> = []
    
    init(store: AppStore,
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
    
    func fetchArticles() {
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
    
    func resetErrors() {
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
