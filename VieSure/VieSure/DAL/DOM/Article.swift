//
//  Article.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation

struct Article: Codable {
    let id: Int
    let title: String
    let articleDescription: String
    let author: String
    let releaseDate: Date
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case articleDescription = "description"
        case author
        case releaseDate = "release_date"
        case image
    }
}
