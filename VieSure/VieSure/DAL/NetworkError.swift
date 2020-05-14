//
//  NetworkError.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case unknown
    case selfNil
    case wrongUrl
    case noInternet
}
