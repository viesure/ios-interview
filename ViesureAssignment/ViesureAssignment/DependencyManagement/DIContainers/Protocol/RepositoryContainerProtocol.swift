//
//  RepositoryContainerProtocol.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import ViesureAssignmentArticleList

protocol RepositoryContainerProtocol {
    var articleRepository: ArticleRepositoryProtocol { get set }
}
