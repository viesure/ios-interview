//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 06.04.21.
//

import Foundation
import ViesureAssignmentCommon

public class ArticleMockFactory {
    static func mock() -> Article {
        let article = Article(id: 1, title: "This is a title", description: "This is a description", author: "Kurt Jacobs", release_date: "6/25/2018", image: "http://dummyimage.com/366x582.png/5fa2dd/ffffff")
        return article
    }
}
