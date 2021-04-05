//
//  AppStore.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import Combine

class AppStore: ObservableObject {
    @Published var appState = AppState()
    @Published var viewModels = AppViewModels()
    @Published var errors = AppErrors()
}

// Components

struct AppState {
    var articles: [Article] = []
}

struct AppViewModels {
    var articles: [ArticleListViewModel] = []
    var articleDetail: ArticleDetailViewModel?
}

struct AppErrors {
    var articleFetchFailure: Bool = false
}
