//
//  UIImageView+Extension.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 13..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    func loadImageForUrl(_ url: URL?, fallbackImage: UIImage?) {
        self.image = fallbackImage

        guard let url = url else {
            return
        }

        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)

                DispatchQueue.main.async { [weak self] in
                    self?.image = UIImage(data: data)
                }
            } catch {
                // Error is handled by the fallback image
            }
        }
    }

}
