//
//  BaseProvider.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation

class BaseProvider: BaseProviding {

    internal let networkConnector: NetworkConnectorProtocol
    internal let apiCache: ApiCacheProtocol

    init(networkConnector: NetworkConnectorProtocol, apiCache: ApiCacheProtocol) {
        self.networkConnector = networkConnector
        self.apiCache = apiCache
    }

}
