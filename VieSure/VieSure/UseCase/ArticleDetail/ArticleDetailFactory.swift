//
//  ArticleDetailFactory.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import UIKit

extension UseCaseFactory {

    static func articleDetailViewController(articleId: Int) -> ArticleDetailViewController {
        let storyboard = UIStoryboard(name: "ArticleDetail", bundle: .main)
        guard let view = storyboard.instantiateInitialViewController() as? ArticleDetailViewController else {
            fatalError("ArticleDetailViewController init")
        }

        let presenter = ArticleDetailPresenter(view: view, articleProvider: ProviderFactory.articleProvider(), articleId: articleId)
        view.presenter = presenter

        return view
    }

}
