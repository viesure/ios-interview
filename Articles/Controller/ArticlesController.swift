//
//  ArticlesController.swift
//  ArticleModule
//
//  Created by Nikola Malinovic on 01.04.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import ArticleModel
import ArticleServiceModule
import CommonModule
import Foundation


public class ArticlesController {
    private let articlesService: ArticleService
    var articles: [Article]?
    
    public init(articlesService: ArticleService) {
        self.articlesService = articlesService
    }
    
    private struct ViewModel {
        //let style: Style
        let articles: [Article]
    }
    
    func getArticles(completion: @escaping (Result<ArticleCall.ReturnType, Error>) -> Void) {
        articlesService.getArticles { [weak self] result in
            
            switch result {
            case .success(let articles):
                self?.configure(withViewModel: ViewModel(articles: articles))
            case .failure:
                #if DEBUG
                print("ERROR>>> ArticlesController getArticles")
                #endif
            }
            completion(result)
        }
    }
    
    private func configure(withViewModel viewModel: ViewModel) {
        articles = sortByDate(articles: viewModel.articles)
    }
    
    private func sortByDate(articles: [Article]) -> [Article] {
        var convertedArray: [Article] = []
        
        for article in articles {
            var article = article
            
            let stringDate = DateConverter.convertDateTo(dateString: article.releaseDate)
            let dateString = DateFormatter.FormatDate.releaseDateFinalFormat.date(from: stringDate)
            
            if let date = dateString {
                let newStringDate = DateFormatter.FormatDate.releaseDateFinalFormat.string(from: date)
                article.releaseDate = newStringDate
                convertedArray.append(article)
            }
        }
        let sortedArticles = convertedArray.sorted(by: { $0.releaseDate.compare($1.releaseDate) == .orderedAscending })
        
        return sortedArticles
    }
}
