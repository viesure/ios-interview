//
//  ArticleDetailViewController.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import UIKit

protocol ArticleDetailViewControlling: class {
    func display(viewContent: ArticleDetailViewContent, warning: String?)
    func display(error: String)
}

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    var presenter: ArticleDetailPresenting!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()

        presenter.didLoad()
    }

    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        dateLabel.font = UIFont.italicSystemFont(ofSize: 14)
        authorLabel.font = UIFont.italicSystemFont(ofSize: 14)
    }

}

extension ArticleDetailViewController: ArticleDetailViewControlling {
    func display(viewContent: ArticleDetailViewContent, warning: String?) {
        if let warning = warning {
            showErrorAlert(message: warning)
        }

        imageView.loadImageForUrl(viewContent.imageUrl, fallbackImage: UIImage(named: "fallback"))
        titleLabel.text = viewContent.title
        dateLabel.text = viewContent.date
        descriptionLabel.text = viewContent.description
        authorLabel.text = viewContent.author
    }

    func display(error: String) {
        showErrorAlert(message: error)
    }

}
