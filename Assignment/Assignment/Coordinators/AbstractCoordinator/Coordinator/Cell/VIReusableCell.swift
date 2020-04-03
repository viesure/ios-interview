//
//  VIReusableCell.swift
//  Assignment
//
//  Created by Stefan Andric on 4/2/20.
//  Copyright © 2020 viesure. All rights reserved.
//

import UIKit

public protocol VIReusableCell {
    static var reuseIdentifier: String { get }
}

public extension VIReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: .main)
    }
}

extension UITableViewCell: VIReusableCell {}
