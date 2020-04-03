//
//  Article.swift
//  ArticleModel
//
//  Created by Nikola Malinovic on 31.03.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import Foundation

public struct Article: Codable {
    public let id: Int
    public let title, articleDescription, author: String
    public var releaseDate: String
    public let image: URL

    enum CodingKeys: String, CodingKey {
        case id, title
        case articleDescription = "description"
        case author
        case releaseDate = "release_date"
        case image
    }
}
