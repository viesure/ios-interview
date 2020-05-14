//
//  ArticleCell.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import UIKit

class ArticleCell: UITableViewCell {

    struct ViewContent {
        let title: String
        let description: String
        let imageUrl: URL?
    }

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        headerImageView.layer.cornerRadius = headerImageView.bounds.size.width / 2
        headerImageView.clipsToBounds = true
        headerImageView.contentMode = .scaleAspectFill
        backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 2
    }

    // MARK: - Api

    func display(viewContent: ViewContent) {
        headerImageView.loadImageForUrl(viewContent.imageUrl, fallbackImage: UIImage(named: "fallback"))
        titleLabel.text = viewContent.title
        descriptionLabel.text = viewContent.description
    }

}
