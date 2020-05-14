//
//  UIView+Extension.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: .main)
    }

    static func reuseIdentifier() -> String {
        return NSStringFromClass(self)
    }

}
