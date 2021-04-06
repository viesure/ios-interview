//
//  ApplicationContainerMock.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import ViesureAssignmentCommon

struct ApplicationContainerMock: ApplicationContainerProtocol {
    var store: AppStore
    var workerContainer: WorkerContainerProtocol
    var repositoryContainer: RepositoryContainerProtocol
    var interactorContainer: InteractorContainerProtocol

    init() {
        self.store = AppStore()
        self.workerContainer = WorkerContainer()
        self.repositoryContainer = RepositoryContainerMock()
        self.interactorContainer = InteractorContainer(store: store,
                                                       workerContainer: workerContainer,
                                                       repositoryContainer: repositoryContainer)

        InteractorContainerKey.defaultValue = self.interactorContainer
    }

}
