//
//  ArticleListPresenter.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import UIKit

class ArticleListPresenter {

    private weak var view: ArticleListViewControlling?
    private let articleProvider: ArticleProviding

    // MARK: - Init

    init(view: ArticleListViewControlling, articleProvider: ArticleProviding) {
        self.view = view
        self.articleProvider = articleProvider
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
                    self.view?.display(viewContent: self.viewContentFrom(articles: data.result), warning: nil)

                case .errorWithCache(let error, let cache):
                    let warning: String = {
                        let errorPart = "Error happened: \(error)\n"
                        guard let ageInMinutes = cache.source.age().dateDiffInMinutes() else {
                            return errorPart
                        }

                        return errorPart + "The data you can see is \(ageInMinutes) old"
                    }()
                    self.view?.display(viewContent: self.viewContentFrom(articles: cache.result), warning: warning)

                case .error(let error):
                    self.view?.display(error: error.localizedDescription)
                }
            }

        }
    }

    // MARK: - Private

    private func viewContentFrom(articles: [Article]) -> ArticleListViewContent {
        let sortedArticles = articles.sorted(by: { $0.releaseDate > $1.releaseDate })

        let rows = sortedArticles.map { article -> ArticleListViewContent.Row in
            let title = article.title
            let description = article.articleDescription
            let imageUrl = URL(string: article.image)
            let onClick: () -> Void = { [weak self] in
                self?.openDetail(id: article.id)
            }

            return ArticleListViewContent.Row.init(articleTitle: title, articleDescription: description, articleImageUrl: imageUrl, onClick: onClick)
        }

        return ArticleListViewContent(rows: rows)
    }

    private func openDetail(id: Int) {
        let detail = UseCaseFactory.articleDetailViewController(articleId: id)
        view?.openDetail(viewController: detail)
    }

}
