//
//  VIArticleTableViewCell.swift
//  Assignment
//
//  Created by Stefan Andric on 4/2/20.
//  Copyright © 2020 viesure. All rights reserved.
//

import UIKit

class VIArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var articleImageView: UIImageView! {
        didSet {
            articleImageView.layer.cornerRadius = articleImageView.frame.size.height/2
        }
    }
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
}
