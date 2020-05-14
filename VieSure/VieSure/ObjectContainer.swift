//
//  ObjectContainer.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation

struct ObjectContainer {

    static let sharedContainer = ObjectContainer()

    let apiCache: ApiCache

    private init() {
        let persistProvider = UserDefaultsPersistProvider(providerName: "ApiCachePersistProvider", maxAge: 7*24*60*60)
        self.apiCache = ApiCache.init(entryLifeTime: 5*60, maximumEntryCount: 1000, persistProvider: persistProvider)
    }

}
