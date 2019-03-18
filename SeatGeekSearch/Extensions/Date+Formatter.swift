//
//  Date+Formatter.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/15/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from:self)
    }
}

extension Date {
    func prettyFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, MMM dd, yyyy hh:mm a"
        return dateFormatter.string(from: self)
    }
}
