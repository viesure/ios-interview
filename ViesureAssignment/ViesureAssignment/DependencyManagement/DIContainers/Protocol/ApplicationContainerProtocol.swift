//
//  ApplicationContainerProtocol.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

protocol ApplicationContainerProtocol {
    var store: AppStore { get set }
    var workerContainer: WorkerContainerProtocol { get set }
    var repositoryContainer: RepositoryContainerProtocol { get set }
    var interactorContainer: InteractorContainerProtocol { get set }
    init()
}
