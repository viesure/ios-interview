//
//  ArticlesViewController.swift
//  Articles
//
//  Created by Nikola Malinovic on 31.03.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import ArticleServiceModule
import CommonModule
import Kingfisher
import UIKit

public class ArticlesViewController: UIViewController {
    
    private let articlesTableView = UITableView()
    
    private var topMostViewController: UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
    
    private let controller: ArticlesController = {
        let controller = ArticlesController(articlesService: ArticleServiceImpl(baseURL: Environment.current.url))
        //        let controller = ArticlesController(articlesService: ArticleOfflineImpl())
        return controller
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.accessibilityIdentifier = "ArticlesViewController"
        articlesTableView.delegate = self
        articlesTableView.dataSource = self
        
        articlesTableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: String(describing: ArticleTableViewCell.self))
        articlesTableView.accessibilityIdentifier = "articlesTableView"
        
        view.addSubview(articlesTableView)
        NSLayoutConstraint.activateUsingAutoLayout([
            articlesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            articlesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            articlesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            articlesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        controller.getArticles(completion: { result in
            self.articlesTableView.reloadData()
        })
    }
}

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.articles?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleTableViewCell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: ArticleTableViewCell.self), for: indexPath) as?
            ArticleTableViewCell ?? ArticleTableViewCell()
        articleTableViewCell.accessibilityIdentifier = "articleTableViewCell"
        
        articleTableViewCell.articleImageView.kf.setImage(with: controller.articles?[indexPath.row].image)
        articleTableViewCell.title.text = controller.articles?[indexPath.row].title
        articleTableViewCell.articleDescription.text = controller.articles?[indexPath.row].articleDescription
        
        return articleTableViewCell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailViewController = ArticleDetailViewController(navigationBarTitle: "navigationbar.article.detail.title",
                                                               cancelButtonText: "navigationbar.cancel.button")
        
        detailViewController.articleImageView.kf.setImage(with: controller.articles?[indexPath.row].image)
        detailViewController.articleTitle.text = controller.articles?[indexPath.row].title
        
        let stringDate = controller.articles?[indexPath.row].releaseDate ?? ""
        detailViewController.releaseDate.text = stringDate
        
        detailViewController.articleDescription.text = controller.articles?[indexPath.row].articleDescription
        detailViewController.author.text =
        "\(String.localized(forKey: "article.author"))\(controller.articles?[indexPath.row].author ?? "")"
        
        let rootViewController = UINavigationController(rootViewController: detailViewController)
        rootViewController.navigationBar.barTintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray]
        rootViewController.navigationBar.titleTextAttributes = textAttributes
        topMostViewController?.present(rootViewController, animated: true, completion: nil)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
