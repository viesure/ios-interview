//
//  Helper.swift
//  CommonModule
//
//  Created by Nikola Malinovic on 02.04.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

import Foundation

public class DateConverter {
    public static func convertDateTo(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        guard let firstDateFormat = DateFormatter.FormatDate.releaseDateIncomingFormat.date(from: dateString) else {
            return ""
        }
        let secondDateFormat = DateFormatter.FormatDate.releaseDateFinalFormat.string(from: firstDateFormat)
        return secondDateFormat
    }
}
