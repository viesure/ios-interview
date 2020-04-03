//
//  VIArticlesDatatypes.swift
//  Assignment
//
//  Created by Stefan Andric on 4/2/20.
//  Copyright © 2020 viesure. All rights reserved.
//

import Foundation

struct VIArticle: Codable {
    let id: Int
    let title, articleDescription, author: String
    let image: String
    let releaseDate: Date
    
    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, ''yy"
        
        return formatter.string(from: releaseDate)
    }
    
    var imageUrl: URL {
        return URL(string: image) ?? URL(string: "")!
    }
    
    var authorDecorated: String {
        return "Author: " + author
    }

    enum CodingKeys: String, CodingKey {
        case id, title
        case articleDescription = "description"
        case author
        case releaseDate = "release_date"
        case image
    }
}
