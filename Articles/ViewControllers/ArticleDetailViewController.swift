//
//  ArticleDetailViewController.swift
//  ArticleModule
//
//  Created by Nikola Malinovic on 31.03.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import CommonModule
import UIKit

class ArticleDetailViewController: UIViewController {
    
    private let navigationBarTitle: String
    private let cancelButtonText: String
    
    let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = "articleImageView"
        return imageView
    }()
    let articleTitle: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "articleTitle"
        return label
    }()
    let releaseDate: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.accessibilityIdentifier = "releaseDate"
        return label
    }()
    let articleDescription: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Arial", size: 15)
        textView.accessibilityIdentifier = "articleDescription"
        return textView
    }()
    let author: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "author"
        return label
    }()
    
    init(navigationBarTitle: String, cancelButtonText: String) {
        self.navigationBarTitle = navigationBarTitle
        self.cancelButtonText = cancelButtonText
        super.init(nibName: nil, bundle: nil)
        title = String.localized(forKey: navigationBarTitle)
        let dismissButton = UIBarButtonItem(title: String.localized(forKey: cancelButtonText),
                                            style: .plain,
                                            target: self,
                                            action: #selector(dismissViewController))
        dismissButton.accessibilityIdentifier = "dismissButton"
        self.navigationItem.leftBarButtonItem = dismissButton
        
        view.addSubview(articleImageView)
        view.addSubview(articleTitle)
        view.addSubview(releaseDate)
        view.addSubview(articleDescription)
        view.addSubview(author)
        
        NSLayoutConstraint.activateUsingAutoLayout([
            articleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            articleImageView.topAnchor.constraint(equalTo: view.topAnchor),
            articleImageView.bottomAnchor.constraint(equalTo: articleTitle.topAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 200),
            
            articleTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            articleTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            articleTitle.topAnchor.constraint(equalTo: articleImageView.bottomAnchor),
            
            releaseDate.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            releaseDate.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            releaseDate.topAnchor.constraint(equalTo: articleTitle.bottomAnchor),
            
            articleDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            articleDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            articleDescription.topAnchor.constraint(equalTo: releaseDate.bottomAnchor),
            articleDescription.heightAnchor.constraint(equalToConstant: 300),
            
            author.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            author.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            author.topAnchor.constraint(equalTo: articleDescription.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        super.loadView() // ui tests required
        view = ArticleDetailView()
        view.backgroundColor = .white
    }
    
    @objc
    private func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
