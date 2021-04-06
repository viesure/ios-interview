//
//  InteractorContainerProtocol.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import ViesureAssignmentCommon
import ViesureAssignmentArticleDetail
import ViesureAssignmentArticleList

protocol InteractorContainerProtocol {
    init(store: AppStore, workerContainer: WorkerContainerProtocol,
         repositoryContainer: RepositoryContainerProtocol)
    var store: AppStore { get set }
    var workerContainer: WorkerContainerProtocol { get set }
    var repositoryContainer: RepositoryContainerProtocol { get set }

    var articleInteractor: ArticleListInteractorProtocol { get set }
    var articleDetailInteractor: ArticleDetailInteractorProtocol { get set }
}
