//
//  VIArticlesService.swift
//  Assignment
//
//  Created by Stefan Andric on 4/2/20.
//  Copyright © 2020 viesure. All rights reserved.
//

import Foundation

class VIArticlesService: VIAbstractService {
    func getArticles(handler: @escaping(([VIArticle]?, Error?) -> Void)) {
        let request = createRequest(path: "/articles")
        
        session.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data else {
                handler(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "mm/dd/yyyy"
                dateFormatter.locale = .current
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let articles = try? decoder.decode([VIArticle].self, from: data)
                handler(articles, error)
            }
        }.resume()
    }
}
