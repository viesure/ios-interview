//
//  ArticleDetailView.swift
//  Articles
//
//  Created by Nikola Malinovic on 01.04.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import UIKit

class ArticleDetailView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let title = UILabel()
    private let releaseDate = UILabel()
    private let articleDescription = UITextView()
    private let author = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.accessibilityIdentifier = "ArticleDetailView"
        
        addSubview(stackView)
        stackView.addArrangedSubview(articleImageView)
        
        NSLayoutConstraint.activateUsingAutoLayout([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            articleImageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            articleImageView.topAnchor.constraint(equalTo: stackView.topAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
