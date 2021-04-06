//
//  ArticleDetailViewModel.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

public struct ArticleDetailViewModel: Identifiable {
    public var id: Int
    public var title: String
    public var description: String
    public var author: String
    public var release_date: String
    public var image: URL?
    
    public init(article: Article) {
        self.id = article.id
        self.title = article.title
        self.description = article.description
        self.image = URL(string: article.image)
        self.release_date = ArticleDetailViewModel.format(dateString: article.release_date)
        self.author = "Author: \(article.author)"
    }
    
    public static func format(dateString: String) -> String {
        let formatterToDate = DateFormatter()
        formatterToDate.dateFormat = "mm/dd/yyyy"
        guard let dateConverted = formatterToDate.date(from: dateString) else {
            return ""
        }
        
        let formatterToCustomDateString = DateFormatter()
        formatterToCustomDateString.dateFormat = "EE, MMM dd, ''yy"
        return formatterToCustomDateString.string(from: dateConverted)
        
    }
}
