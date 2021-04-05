//
//  WorkerContainerProtocol.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

protocol WorkerContainerProtocol {
    var encryptionWorker: EncryptionWorkerProtocol { get set }
    var fileWriterWorker: FileWriterWorkerProtocol { get set }
    var articleDateFilterWorker: ArticleDateFilterWorkerProtocol { get set }
}
