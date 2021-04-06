//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 06.04.21.
//

import Foundation
import ViesureAssignmentCommon

public protocol ArticleListInteractorProtocol {
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
