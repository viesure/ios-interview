//
//  ArticleListViewContent.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import UIKit

struct ArticleListViewContent {

    struct Row {
        let articleTitle: String
        let articleDescription: String
        let articleImageUrl: URL?
        let onClick: ()->Void
    }

    let rows: [Row]
}
