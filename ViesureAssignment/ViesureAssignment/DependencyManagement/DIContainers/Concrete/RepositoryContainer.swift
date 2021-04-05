//
//  RepositoryContainer.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

struct RepositoryContainer: RepositoryContainerProtocol {
    var articleRepository: ArticleRepositoryProtocol = ArticleRepository()
}
