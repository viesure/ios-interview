//
//  StoreDataViewModel.swift
//  viesure_iOS_interview
//
//  Created by Primoz Cuvan on 23.04.21.
//  Copyright © 2021 Primoz Cuvan. All rights reserved.
//

import Foundation
import RNCryptor

class StoreDataViewModel {
    //MARK: archiveData
    func archiveData(data: Data, articleNumber: Int, detail: Int) {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let archiveURL = URL(fileURLWithPath: "Article:\(articleNumber),detail:\(detail)", relativeTo: directoryURL.appendingPathComponent("article"))
        do {
            try data.write(to: archiveURL)
        } catch {
            print("error saving")
        }
    }
    
    //MARK: unarchiveData
    func unarchiveData(numberOfArticles: Int) -> [ArticleModel] {
        var articles: [ArticleModel] = []
        var details: [String] = []
        
        for articleNumber in 0...numberOfArticles {
            for detail in 0...4 {
                details.append(asignUnarchivedDataToArticleModel(articleNumber, detail))
            }
            
            articles.append(ArticleModel(id: articleNumber,
                                         title: details[0],
                                         description: details[1],
                                         author: details[2],
                                         release_date: details[3],
                                         image: details[4]))
            details.removeAll()
        }
        return articles
    }
    
    //MARK: asignUnarchivedDataToArticleModel
    private func asignUnarchivedDataToArticleModel(_ articleNumber: Int, _ detail: Int) -> String {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let archiveURL = URL(fileURLWithPath: "Article:\(articleNumber),detail:\(detail)", relativeTo: directoryURL.appendingPathComponent("article"))
        
        if FileManager.default.fileExists(atPath: archiveURL.path) {
            do {
                let data = try Data.init(contentsOf: archiveURL)
                return String(data: data, encoding: .utf8) ?? "000"
            } catch let error {
                print(error)
            }

        }
        return "000"
    }
}
