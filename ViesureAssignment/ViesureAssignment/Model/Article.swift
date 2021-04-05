//
//  Article.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

struct Article: Codable, Identifiable, Equatable {
    var id: Int
    var title: String
    var description: String
    var author: String
    var release_date: String
    var image: String
}
