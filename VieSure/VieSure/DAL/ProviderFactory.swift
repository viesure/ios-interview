//
//  ProviderFactory.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation

protocol ProviderFactoryProtocol {
    static func articleProvider() -> ArticleProviding
}

struct ProviderFactory: ProviderFactoryProtocol {

}
