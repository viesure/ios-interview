//
//  ArticleDateFilterWorker.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 05.04.21.
//

import Foundation

class ArticleDateFilterWorker: ArticleDateFilterWorkerProtocol {
    func applyDateFilter(articles: [Article]) -> [Article] {
        return articles.sorted { (left, right) -> Bool in
            let formatterToDate = DateFormatter()
            formatterToDate.dateFormat = "mm/dd/yyyy"
            guard let leftDate = formatterToDate.date(from: left.release_date) else { return false }
            guard let rightDate = formatterToDate.date(from: right.release_date) else { return true }
            return leftDate > rightDate
        }
    }
}
