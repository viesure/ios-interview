//
//  RepositoryContainer.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import ViesureAssignmentArticleList

struct RepositoryContainer: RepositoryContainerProtocol {
    var articleRepository: ArticleRepositoryProtocol = ArticleRepository()
}
