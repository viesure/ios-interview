//
//  VIArticlesViewController.swift
//  Assignment
//
//  Created by Stefan Andric on 4/2/20.
//  Copyright © 2020 viesure. All rights reserved.
//

import UIKit
import Kingfisher

class VIArticlesViewController: UIViewController {
    let viewModel = VIArticlesViewModel()
    
    var didSelectArticle: ((VIArticle) -> Void)?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Articles"
        setupTableView()
        
        fetchArticles()
    }
    
    @objc private func fetchArticles() {
        viewModel.fetchArticles { [weak self] in
            guard let self = self else {
                return
            }
            OperationQueue.main.addOperation {
                self.updateUI()
            }
        }
    }
}

// MARK: TableViewDelegate and DataSource
extension VIArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VIArticleTableViewCell.reuseIdentifier) as? VIArticleTableViewCell else {
            return UITableViewCell()
        }

        let article = viewModel.article(for: indexPath)
        setup(cell: cell, with: article)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.article(for: indexPath)
        
        didSelectArticle?(article)
    }
}

// MARK: UITableViewCell setup
// NOTE: Could be moved to the sort of decorating class that is dedicated(to offload plain ui work from controller)
extension VIArticlesViewController {
    func setup(cell: VIArticleTableViewCell, with article: VIArticle) {
        cell.selectionStyle = .none
        cell.articleTitleLabel.text = article.title
        cell.articleDescriptionLabel.text = article.articleDescription
        
        cell.articleImageView.kf.setImage(with: article.imageUrl)
    }
}

// MARK: UI helpers
extension VIArticlesViewController {
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 100.00
        
        tableView.register(VIArticleTableViewCell.nib, forCellReuseIdentifier: VIArticleTableViewCell.reuseIdentifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchArticles), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func updateUI() {
        tableView.reloadSections([0], with: .automatic)
        updateEmptyView()
        tableView.refreshControl?.endRefreshing()
    }
    
    private func updateEmptyView() {
        guard viewModel.areArticlesEmpty else {
            return
        }
        
        let label = UILabel(frame: tableView.frame)
        label.text = "No articles 😔. Pull to refresh to get the latest data. 🔝"
        label.textAlignment = .center
        label.numberOfLines = 0
        tableView.backgroundView = label
    }
}
