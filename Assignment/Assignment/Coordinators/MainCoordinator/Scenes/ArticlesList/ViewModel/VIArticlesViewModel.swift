//
//  VIArticlesViewModel.swift
//  Assignment
//
//  Created by Stefan Andric on 4/2/20.
//  Copyright © 2020 viesure. All rights reserved.
//

import Foundation

class VIArticlesViewModel {
    private var model = VIArticlesModel()
    private let service = VIArticlesService()
    
    var numberOfRows: Int {
        return model.articles.count
    }
    
    var areArticlesEmpty: Bool {
        return model.articles.isEmpty
    }
    
    func article(for indexPath: IndexPath) -> VIArticle {
        return model.articles[indexPath.row]
    }
    
    func fetchArticles(handler: @escaping(() -> Void)) {
        service.getArticles { (articles, error) in
            defer { handler() }
            
            if let articles = articles {
                // Save the fetched ones and persist them.
                self.sortAndSaveArticles(articles)
            } else {
                // Backup option, retreive locally if there is any
                self.sortAndSaveArticles(self.getLocalCopyOfArticles())
            }
        }
    }
    
    // MARK: -
    private func sortAndSaveArticles(_ articles: [VIArticle]) {
        let sortedArticles = articles.sorted(by: {
            $0.releaseDate.compare($1.releaseDate) == .orderedDescending
        })
        persistArticles(articles)
        self.model.articles = sortedArticles
    }
    
    func persistArticles(_ articles: [VIArticle]) {
        VIStorage.store(articles, to: .documents, as: "articles.json")
    }
    
    func getLocalCopyOfArticles() -> [VIArticle] {
        if VIStorage.fileExists("articles.json", in: .documents) {
            let articles = VIStorage.retrieve("articles.json", from: .documents, as: [VIArticle].self)
            
            return articles
        }
        
        return [VIArticle]()
    }
}
