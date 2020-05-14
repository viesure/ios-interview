//
//  TestNetworkConnector.swift
//  VieSureTests
//
//  Created by Papp Balázs on 2020. 05. 13..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
@testable import VieSure

class TestNetworkConnector: NetworkConnectorProtocol {

    var result: Result<Data, Error>!

    func requestFromUrl(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        completion(result)
    }
}
