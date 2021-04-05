//
//  InteractorContainer.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

struct InteractorContainer: InteractorContainerProtocol {
    var store: AppStore
    var workerContainer: WorkerContainerProtocol
    var repositoryContainer: RepositoryContainerProtocol

    var articleInteractor: ArticleListInteractorProtocol
    var articleDetailInteractor: ArticleDetailInteractorProtocol
    
    init(store: AppStore,
         workerContainer: WorkerContainerProtocol,
         repositoryContainer: RepositoryContainerProtocol) {
        self.store = store
        
        self.workerContainer = workerContainer
        self.repositoryContainer = repositoryContainer
        
        self.articleInteractor = ArticleListInteractor(store: store,
                                                   articleRepository: repositoryContainer.articleRepository,
                                                   encryptionWorker: workerContainer.encryptionWorker,
                                                   fileWriterWorker: workerContainer.fileWriterWorker,
                                                   articleDateFilterWorker: workerContainer.articleDateFilterWorker)
        self.articleDetailInteractor = ArticleDetailInteractor(store: store)
    }
}
