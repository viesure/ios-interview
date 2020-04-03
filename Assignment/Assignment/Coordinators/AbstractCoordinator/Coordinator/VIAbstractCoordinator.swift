//
//  VIAbstractCoordinator.swift
//  Assignment
//
//  Created by Stefan Andric on 4/2/20.
//  Copyright © 2020 viesure. All rights reserved.
//

import UIKit

protocol VICoordinator {
    var childCoordinators: [VICoordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
