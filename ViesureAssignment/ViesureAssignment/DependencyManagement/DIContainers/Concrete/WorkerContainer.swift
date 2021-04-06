//
//  WorkerContainer.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import ViesureAssignmentCommon
import ViesureAssignmentArticleList

struct WorkerContainer: WorkerContainerProtocol {
    var encryptionWorker: EncryptionWorkerProtocol = EncryptionWorker()
    var fileWriterWorker: FileWriterWorkerProtocol = FileWriterWorker()
    var articleDateFilterWorker: ArticleDateFilterWorkerProtocol = ArticleDateFilterWorker()
}
