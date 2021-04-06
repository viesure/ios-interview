//
//  ArticleListViewModel.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

public struct ArticleListViewModel: Identifiable {
    public var id: Int
    public var title: String
    public var description: String
    public var image: URL?
    
    public init(article: Article) {
        self.id = article.id
        self.title = article.title
        self.description = article.description
        self.image = URL(string: article.image)
    }
}
