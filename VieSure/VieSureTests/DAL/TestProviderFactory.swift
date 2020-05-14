//
//  TestProviderFactory.swift
//  VieSureTests
//
//  Created by Papp Balázs on 2020. 05. 13..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
@testable import VieSure

class TestProviderFactory {

    static func articleProvider() -> TestArticleProvider {
        TestArticleProvider()
    }

}
