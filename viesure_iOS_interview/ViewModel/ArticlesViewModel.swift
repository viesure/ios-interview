//
//  ArticlesViewModel.swift
//  viesure_iOS_interview
//
//  Created by Primoz Cuvan on 23.04.21.
//  Copyright © 2021 Primoz Cuvan. All rights reserved.
//

import Foundation

class ArticlesViewModel: ObservableObject {
    @Published var articles = [ArticleModel]()
    
    init() {
        self.fetchArticles()
    }
    
    ///Fetch articles from an API url
    private func fetchArticles() {
        guard let url = URL(string: API.url) else { return }
        var fetchedArticles: [ArticleModel] = []
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                do {
                    guard let safeData = data else { return }
                    fetchedArticles = try JSONDecoder().decode([ArticleModel].self, from: safeData)
                    fetchedArticles.sortByDate()
                    self.articles = fetchedArticles
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}

extension Array where Element == ArticleModel {
    mutating func sortByDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        self.sort { (article1, article2) -> Bool in
            formatter.date(from: article1.release_date)! > formatter.date(from: article2.release_date)!
        }
    }
}
