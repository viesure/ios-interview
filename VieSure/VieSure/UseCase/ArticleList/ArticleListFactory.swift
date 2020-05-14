//
//  ArticleListFactory.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import UIKit

extension UseCaseFactory {

    static func articleListViewController() -> ArticleListViewController {
        let storyboard = UIStoryboard(name: "ArticleList", bundle: .main)
        guard let view = storyboard.instantiateInitialViewController() as? ArticleListViewController else {
            fatalError("ArticleListViewController init")
        }

        let presenter = ArticleListPresenter(view: view, articleProvider: ProviderFactory.articleProvider())
        view.presenter = presenter

        return view
    }

}
