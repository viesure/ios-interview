//
//  ArticleModel.swift
//  viesure_iOS_interview
//
//  Created by Primoz Cuvan on 23.04.21.
//  Copyright © 2021 Primoz Cuvan. All rights reserved.
//

import Foundation

struct ArticleModel: Identifiable, Decodable {
    let id: Int
    let title: String
    let description: String
    let author: String
    let release_date: String
    let image: String
}
