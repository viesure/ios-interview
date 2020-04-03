//
//  ArticleTableViewCell.swift
//  Articles
//
//  Created by Nikola Malinovic on 01.04.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import UIKit

public class ArticleTableViewCell: UITableViewCell {
    
    let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        //label.font = UIFont(name: "Arial", size: 16)
        return label
    }()
    
    let articleDescription: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(articleImageView)
        contentView.addSubview(title)
        contentView.addSubview(articleDescription)
        
        NSLayoutConstraint.activateUsingAutoLayout([
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            articleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 40),
            articleImageView.widthAnchor.constraint(equalToConstant: 40),
            
            title.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 20),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            title.bottomAnchor.constraint(equalTo: articleDescription.topAnchor),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            articleDescription.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 20),
            articleDescription.topAnchor.constraint(equalTo: title.bottomAnchor),
            articleDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            articleDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            articleDescription.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
