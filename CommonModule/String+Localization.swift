//
//  String+Localization.swift
//  CommonModule
//
//  Created by Nikola Malinovic on 31.03.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import Foundation

extension String {
    public static func localized(forKey key: String) -> String {
        var result = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
        
        if result == key {
            result = Bundle.main.localizedString(forKey: key, value: nil, table: "Localization")
        }
        return result
    }
}
