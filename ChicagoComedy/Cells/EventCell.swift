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
    
    var event:Event? {
        didSet {
            guard let event = event else {
                return
            }
            name.text = event.name
            venueLabel.text = event.venueName ?? "No venue"
            let startTime = event.localStartTime ?? ""
            let startDate = event.localStartDate ?? ""
            dateTimeLabel.text = "\(startDate), \(startTime)"
            
            if let startDateTime = event.localStart {
                let theFormatter = DateFormatter()
                theFormatter.dateFormat = "E"
                let day = theFormatter.string(from: startDateTime)
                theFormatter.dateFormat = "h:mma"
                let time = theFormatter.string(from: startDateTime)
                dayLabel.text = day
                startTimeLabel.text = time
            }
        }
    }
}
