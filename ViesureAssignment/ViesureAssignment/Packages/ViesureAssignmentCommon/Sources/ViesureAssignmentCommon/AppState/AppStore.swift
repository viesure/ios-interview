//
//  AppStore.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import Combine

public class AppStore: ObservableObject {
    @Published public var appState = AppState()
    @Published public var viewModels = AppViewModels()
    @Published public var errors = AppErrors()
    
    public init() {}
}

// Components

public struct AppState {
    public var articles: [Article] = []
}

public struct AppViewModels {
    public var articles: [ArticleListViewModel] = []
    public var articleDetail: ArticleDetailViewModel?
}

public struct AppErrors {
    public var articleFetchFailure: Bool = false
}
