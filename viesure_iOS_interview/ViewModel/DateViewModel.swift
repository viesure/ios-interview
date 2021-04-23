//
//  DateViewModel.swift
//  viesure_iOS_interview
//
//  Created by Primoz Cuvan on 23.04.21.
//  Copyright © 2021 Primoz Cuvan. All rights reserved.
//

import Foundation

class DateViewModel: ObservableObject {
    @Published var date = String()

    init(date: String) {
        changeDateFormat(dateString: date)
    }
    
    private func changeDateFormat(dateString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        guard let newDate = formatter.date(from: dateString) else { return }
        formatter.dateFormat = "EEE, MMM d, yy"
        var newDateString = formatter.string(from: newDate)
        newDateString.insert(contentsOf: " '", at: newDateString.lastIndex(of: " ")!)
        newDateString.remove(at: newDateString.lastIndex(of: " ")!)
        self.date = newDateString
    }
}
