//
//  ArticleDateFilterWorkerProtocol.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 05.04.21.
//

import Foundation

protocol ArticleDateFilterWorkerProtocol {
    func applyDateFilter(articles: [Article]) -> [Article]
}
