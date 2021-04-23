//
//  ArticlesViewModel.swift
//  viesure_iOS_interview
//
//  Created by Primoz Cuvan on 23.04.21.
//  Copyright © 2021 Primoz Cuvan. All rights reserved.
//

import Foundation
import SwiftUI

class ArticlesViewModel: ObservableObject {
    @Published var articles = [ArticleModel]()
    @Published var showingDataSynchronisationFailureAlert = false
    
    private var numberOfTimesTriedFetchingArticles = 0
    private let storeDataViewModel = StoreDataViewModel()
    
    init() {
        self.fetchArticles()
    }
    
    //MARK: fetchArticles
    ///Fetch articles from an API url
    private func fetchArticles() {
        guard let url = URL(string: API.url) else { return }
        var fetchedArticles: [ArticleModel] = []
        numberOfTimesTriedFetchingArticles += 1
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response)
                return
            }
            
            DispatchQueue.main.async {
                do {
                    guard let safeData = data else { return }
                    fetchedArticles = try JSONDecoder().decode([ArticleModel].self, from: safeData)
                    fetchedArticles.sortByDate()
                    self.archiveArticles(articles: fetchedArticles)
                    
                    self.articles = fetchedArticles
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        .resume()
    }
    
    //MARK: handleServerError
    private func handleServerError(_ response: URLResponse?) {
        DispatchQueue.main.async {
            self.articles = self.unarchiveArticles()
            
            guard let httpResponse = response else { return }
            
            if self.numberOfTimesTriedFetchingArticles <= 3 {
                print("httpResponse: \(httpResponse)")
                self.fetchArticles()
            } else {
                self.showingDataSynchronisationFailureAlert = true
            }
        }
    }
    
    //MARK: dataSynchronisationFailureAlert
    func dataSynchronisationFailureAlert() -> Alert {
        return Alert(
            title: Text("Data Synchronisation Failure"),
            message: Text("We apologise but due to a 500 internal server error or network coverage issue we were not able to load the latest articles."),
            dismissButton: .default(Text("OK")))
    }
    
    //MARK: archiveArticles
    private func archiveArticles(articles: [ArticleModel]) {
        var articleNumber = 0
        for article in articles {
            if let title = article.title.data(using: .utf8) {
                storeDataViewModel.archiveData(data: title,
                                                articleNumber: articleNumber,
                                                detail: 0)
            }
            
            if let description = article.description.data(using: .utf8) {
                storeDataViewModel.archiveData(data: description,
                                                articleNumber: articleNumber ,
                                                detail: 1)
            }
            
            if let author = article.author.data(using: .utf8) {
                storeDataViewModel.archiveData(data: author,
                                                articleNumber: articleNumber,
                                                detail: 2)
            }
            
            if let release_date = article.release_date.data(using: .utf8) {
                storeDataViewModel.archiveData(data: release_date,
                                                articleNumber: articleNumber,
                                                detail: 3)
            }
            
            if let image = article.image.data(using: .utf8) {
                storeDataViewModel.archiveData(data: image,
                                                articleNumber: articleNumber,
                                                detail: 4)
            }
            
            articleNumber += 1
        }
        let userDefaults = UserDefaults()
        userDefaults.set(articleNumber - 1, forKey: "NumberOfArticles")
    }
    
    //MARK: unarchiveArticles
    private func unarchiveArticles() -> [ArticleModel] {
        let userDefaults = UserDefaults()
        let numberOfArticles = userDefaults.integer(forKey: "NumberOfArticles")
        
        let articles = storeDataViewModel.unarchiveData(numberOfArticles: numberOfArticles)
        
        return articles
    }
}

extension Array where Element == ArticleModel {
    //MARK: sortByDate Array Extension
    mutating func sortByDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        self.sort { (article1, article2) -> Bool in
            formatter.date(from: article1.release_date)! > formatter.date(from: article2.release_date)!
        }
    }
}
