//
//  ArticleCall.swift
//  ArticleServiceModule
//
//  Created by Nikola Malinovic on 01.04.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import Foundation
import NetworkingModule
import ArticleModel

public class ArticleCall: Call {
    public typealias ReturnType = [Article]
    public var path: String = "articles"
}
