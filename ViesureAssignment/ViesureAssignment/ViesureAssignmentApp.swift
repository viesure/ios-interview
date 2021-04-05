//
//  ViesureAssignmentApp.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import SwiftUI
import Combine

@main
struct ViesureAssignmentApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var applicationContainer: ApplicationContainerProtocol
    
    init() {
        if ExecutionEnvironment.isUITesting() { applicationContainer = ApplicationContainerMock() }
        else { applicationContainer = ApplicationContainer() }
    }
    
    var body: some Scene {
        WindowGroup {
            ArticleListView()
                .environmentObject(applicationContainer.store)
        }
    }
}
