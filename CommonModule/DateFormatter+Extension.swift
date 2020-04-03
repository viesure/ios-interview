//
//  DateFormatter+Extension.swift
//  CommonModule
//
//  Created by Nikola Malinovic on 01.04.20.
//  Copyright © 2020 NikolaMalinovic. All rights reserved.
//

extension DateFormatter {
    public struct FormatDate {
        public static let releaseDateFinalFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, MMM d, ''yy"
            return formatter
        }()
        
        public static let releaseDateIncomingFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/YYYY"
            return formatter
        }()        
    }
}
