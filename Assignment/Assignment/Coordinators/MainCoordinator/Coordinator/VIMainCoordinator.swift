//
//  VIMainCoordinator.swift
//  Assignment
//
//  Created by Stefan Andric on 4/2/20.
//  Copyright © 2020 viesure. All rights reserved.
//

import UIKit

class VIMainCoordinator: VICoordinator {
    var childCoordinators = [VICoordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let articlesViewController = VIArticlesViewController()
        
        articlesViewController.didSelectArticle = { [weak self] article in
            guard let self = self else {
                return
            }
            
            self.handleDidSelect(article: article)
        }
        
        navigationController.pushViewController(articlesViewController, animated: false)
    }
}

extension VIMainCoordinator {
    private func handleDidSelect(article: VIArticle) {
        let articleDetailsViewController = VIArticleDetailsViewController()
        
        articleDetailsViewController.article = article
        
        navigationController.pushViewController(articleDetailsViewController, animated: true)
    }
}
