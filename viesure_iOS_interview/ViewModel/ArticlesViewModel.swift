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
    func fetchArticles() {
        guard let url = URL(string: API.url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                do {
                    guard let safeData = data else { return }
                    self.articles = try JSONDecoder().decode([ArticleModel].self, from: safeData)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
