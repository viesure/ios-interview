//
//  ArticleDetailPresenter.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import UIKit

protocol ArticleDetailPresenting {
    func didLoad()
    var view: ArticleDetailViewControlling? { get }
    var articleProvider: ArticleProviding { get }
    var articleId: Int { get }
}

class ArticleDetailPresenter: ArticleDetailPresenting {

    internal weak var view: ArticleDetailViewControlling?
    internal let articleProvider: ArticleProviding
    internal let articleId: Int

    init(view: ArticleDetailViewControlling?, articleProvider: ArticleProviding, articleId: Int) {
        self.view = view
        self.articleProvider = articleProvider
        self.articleId = articleId
    }

    // MARK: - Api

    func didLoad() {
        articleProvider.fetchArticles(cacheStrategy: .useValidCacheWithForceCacheOnError) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }

                switch result {
                case .success(let data):
                    guard let article = data.result.first(where: { $0.id == self.articleId }) else {
                        self.view?.display(error: "There is no article for the Id")
                        return
                    }

                    self.view?.display(viewContent: self.viewContentFrom(article: article), warning: nil)

                case.errorWithCache(let error, let cache):
                    guard let article = cache.result.first(where: { $0.id == self.articleId }) else {
                        self.view?.display(error: "There is no article for the Id")
                        return
                    }

                    let warning: String = {
                        let errorPart = "Error happened: \(error)"
                        guard let ageInMinutes = cache.source.age().dateDiffInMinutes() else {
                            return errorPart
                        }

                        return errorPart + " The data you can see is \(ageInMinutes) old"
                    }()
                    self.view?.display(viewContent: self.viewContentFrom(article: article), warning: warning)

                case .error(let error):
                    self.view?.display(error: error.localizedDescription)
                }
            }
        }
    }

    // MARK: - Private

    private func viewContentFrom(article: Article) -> ArticleDetailViewContent {
        let imageUrl = URL(string: article.image)
        let title = article.title
        let date = article.releaseDate
        let description = article.articleDescription
        let author = article.author

        return .init(imageUrl: imageUrl, title: title, date: date.prettyDate(), description: description, author: author)
    }

}
