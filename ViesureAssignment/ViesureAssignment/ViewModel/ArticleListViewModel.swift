//
//  ArticleListViewModel.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import ViesureAssignmentCommon

struct ArticleListViewModel: Identifiable {
    var id: Int
    var title: String
    var description: String
    var image: URL?
    
    init(article: Article) {
        self.id = article.id
        self.title = article.title
        self.description = article.description
        self.image = URL(string: article.image)
    }
}
