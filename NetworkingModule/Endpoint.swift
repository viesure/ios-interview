//
//  Endpoint.swift
//  NetworkingModule
//
//  Created by Nikola Malinovic on 31.03.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

public struct Endpoint {
    var baseURL: URL

    public init(baseURL: URL) {
        self.baseURL = baseURL
    }
}
