//
//  ArticleListViewController.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import UIKit

protocol ArticleListViewControlling: class {
    func display(viewContent: ArticleListViewContent, warning: String?)
    func display(error: String)
    func openDetail(viewController: ArticleDetailViewController)
}

class ArticleListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var presenter: ArticleListPresenter!
    private var dataSource: [ArticleListViewContent.Row] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()

        presenter.didLoad()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44

        tableView.register(ArticleCell.nib(), forCellReuseIdentifier: ArticleCell.reuseIdentifier())

        tableView.backgroundColor = .clear
        tableView.clipsToBounds = false
        tableView.scrollIndicatorInsets = .init(top: 0, left: 0, bottom: 0, right: -10)
    }

}

extension ArticleListViewController: ArticleListViewControlling {

    func display(viewContent: ArticleListViewContent, warning: String?) {
        if let warning = warning {
            showErrorAlert(message: warning)
        }

        dataSource = viewContent.rows
        tableView.reloadData()
    }

    func display(error: String) {
        showErrorAlert(message: error)
    }

    func openDetail(viewController: ArticleDetailViewController) {
        present(viewController, animated: true, completion: nil)
    }

}

extension ArticleListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowContent = dataSource[safeIndex: indexPath.section], let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.reuseIdentifier()) as? ArticleCell else {
            return UITableViewCell()
        }

        cell.display(viewContent: .init(title: rowContent.articleTitle, description: rowContent.articleDescription, imageUrl: rowContent.articleImageUrl))


        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }

}

extension ArticleListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = dataSource[safeIndex: indexPath.section]
        row?.onClick()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
