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
        }
    }
}
