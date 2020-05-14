//
//  TestBaseProvider.swift
//  VieSureTests
//
//  Created by Papp Balázs on 2020. 05. 13..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
@testable import VieSure

class TestBaseProvider {

    let delay = 50
    let queue = DispatchQueue(label: "TestBaseProvider")

    func executeDelayed(block: @escaping ()-> Void) {
        queue.asyncAfter(deadline: .now() + .milliseconds(delay)) {
            block()
        }
    }

}
