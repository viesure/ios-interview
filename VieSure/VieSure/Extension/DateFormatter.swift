//
//  DateFormatter.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 13..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation

extension DateFormatter {

    static let vieSureDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    formatter.calendar = Calendar.current
    formatter.locale = Locale.current
    return formatter
  }()

}
