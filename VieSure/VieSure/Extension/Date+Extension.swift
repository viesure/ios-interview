//
//  Date+Extension.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 13..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation

extension Date {

    func dateDiffInMinutes() -> String? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: self, to: Date())

        guard let minutes = components.minute else {
            return nil
        }

        let suffix: String = minutes > 1 ? "minutes" : "minute"

        return "\(minutes) \(suffix)"
    }

    func prettyDate() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "E, MMM d, ''YY'"
        
        return dateformat.string(from: self)
    }

}
