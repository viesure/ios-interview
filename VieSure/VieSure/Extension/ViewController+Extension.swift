//
//  ViewController+Extension.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 13..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error happened", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
