//
//  ArticleDetailViewModel.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

struct ArticleDetailViewModel: Identifiable {
    var id: Int
    var title: String
    var description: String
    var author: String
    var release_date: String
    var image: URL?
    
    init(article: Article) {
        self.id = article.id
        self.title = article.title
        self.description = article.description
        self.image = URL(string: article.image)
        self.release_date = ArticleDetailViewModel.format(dateString: article.release_date)
        self.author = "Author: \(article.author)"
    }
    
    static func format(dateString: String) -> String {
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
