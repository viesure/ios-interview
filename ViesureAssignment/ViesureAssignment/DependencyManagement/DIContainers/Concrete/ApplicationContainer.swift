//
//  ApplicationContainer.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

struct ApplicationContainer: ApplicationContainerProtocol {
    var store: AppStore
    var workerContainer: WorkerContainerProtocol
    var repositoryContainer: RepositoryContainerProtocol
    var interactorContainer: InteractorContainerProtocol
    
    init() {
        self.store = AppStore()
        self.workerContainer = WorkerContainer()
        self.repositoryContainer = RepositoryContainer()
        self.interactorContainer = InteractorContainer(store: store,
                                                       workerContainer: workerContainer,
                                                       repositoryContainer: repositoryContainer)
        
        InteractorContainerKey.defaultValue = self.interactorContainer
    }
}
