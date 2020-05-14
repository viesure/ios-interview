//
//  Array+Extension.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
