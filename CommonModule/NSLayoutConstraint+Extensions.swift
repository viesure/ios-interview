//
//  NSLayoutConstraint+Extensions.swift
//  CommonModule
//
//  Created by Nikola Malinovic on 31.03.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {
    class func activateUsingAutoLayout(_ constraints: [NSLayoutConstraint]) {
        for constraint in constraints {
            if let view = constraint.firstItem as? UIView {
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        activate(constraints)
    }
}
