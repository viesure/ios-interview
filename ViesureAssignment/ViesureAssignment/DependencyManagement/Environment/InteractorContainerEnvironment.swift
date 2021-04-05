//
//  ArticlesInteractorEnvironment.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import SwiftUI

struct InteractorContainerKey: EnvironmentKey {
    static var defaultValue: InteractorContainerProtocol?
}

extension EnvironmentValues {
    var interactorContainer: InteractorContainerProtocol? {
        get { return self[InteractorContainerKey.self] }
        set { self[InteractorContainerKey.self] = newValue }
    }
}
