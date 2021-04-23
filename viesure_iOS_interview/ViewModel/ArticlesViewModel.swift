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
                    self.articles = fetchedArticles
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        .resume()
    }
    
    private func handleServerError(_ response: URLResponse?) {
        guard let httpResponse = response else { return }
        
        if numberOfTimesTriedFetchingArticles <= 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print("httpResponse: \(httpResponse)")
                self.fetchArticles()
            }
        } else {
            DispatchQueue.main.async {
                    self.showingDataSynchronisationFailureAlert = true
            }
        }
    }
    
    //MARK: dataSynchronisationFailureAlert
    func dataSynchronisationFailureAlert() -> Alert {
        return Alert(
            title: Text("Data Synchronisation Failure"),
            message: Text("We apologise bu due to a 500 internal server error or network coverage issue we were not able to load the latest articles."),
            dismissButton: .default(Text("OK")))
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
