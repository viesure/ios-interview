//
//  VIArticleDetailsViewController.swift
//  Assignment
//
//  Created by Stefan Andric on 4/2/20.
//  Copyright © 2020 viesure. All rights reserved.
//

import UIKit
import Kingfisher

class VIArticleDetailsViewController: UIViewController {
    @IBOutlet weak var articleTitleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDateLabel: UILabel!
    @IBOutlet weak var articleDetailsTextView: UITextView!
    @IBOutlet weak var articleAuthorLabel: UILabel!
    
    var article: VIArticle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Article details"
        
        guard let article = article else {
            return
        }
        
        articleTitleImageView.kf.setImage(with: article.imageUrl)
        articleTitleLabel.text = article.title
        articleDateLabel.text = article.date
        articleDetailsTextView.text = article.articleDescription
        articleAuthorLabel.text = article.authorDecorated
        
        // Do any additional setup after loading the view.
    }
}
