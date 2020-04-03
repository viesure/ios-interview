//
//  APIError.swift
//  NetworkingModule
//
//  Created by Nikola Malinovic on 31.03.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

enum APIError: Error {
    case baseURLNil
    case dataNil
    case decodingError
    case requestNil
}
