//
//  EventCell.swift
//  ChicagoComedy
//
//  Created by ARO on 10/6/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class EventCell: UITableViewCell {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var venueLabel: UILabel!
    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var startTimeLabel: UILabel!
    
    var event:NSDictionary? {
        didSet {
            guard let event = event else {
                return
            }
            name.text = event.value(forKey: "name") as? String
            venueLabel.text = event.value(forKey: "venue_name") as? String ?? "No venue"
            let startTime = (event.value(forKey: "localstarttime") as? String) ?? ""
            let startDate = (event.value(forKey: "localstartdate") as? String) ?? ""
            dateTimeLabel.text = "\(startDate) \(startTime)"
            
            if let startDateTime = event.value(forKey: "local_start") as? String, !startDateTime.isEmpty {
                let theFormatter = DateFormatter()
                theFormatter.timeZone = TimeZone(identifier: "America/Chicago")
                theFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date = theFormatter.date(from: startDateTime)
                theFormatter.dateFormat = "E"
                let day = theFormatter.string(from: date!)
                theFormatter.dateFormat = "h:mma"
                let time = theFormatter.string(from: date!)
                dayLabel.text = day
                startTimeLabel.text = time
            }
        }
    }
}
