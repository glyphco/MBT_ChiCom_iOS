//
//  Date+DateParsing.swift
//  ChicagoComedy
//
//  Created by ARO on 10/20/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation

extension Date {
    
    static let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "America/Chicago")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    static func parseDateFrom(string: String) -> Date? {
        
        var result:Date
        
        if let date = fullDateFormatter.date(from: string) {
            result = date
        } else {
            result = Date()
        }
        
        return result
    }

}
