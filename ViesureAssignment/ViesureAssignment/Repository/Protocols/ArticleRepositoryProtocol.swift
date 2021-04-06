//
//  ArticleRepositoryProtocol.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import Combine
import ViesureAssignmentCommon

protocol ArticleRepositoryProtocol {
    func get(configuration: URLSessionConfiguration) -> AnyPublisher<[Article], Error>
}
