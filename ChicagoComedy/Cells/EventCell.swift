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
    
    var event:NSDictionary? {
        didSet {
            guard let event = event else {
                return
            }
            name.text = event.value(forKey: "name") as? String
            
            if let imageUrl = event.value(forKey: "imageSm") as? String, !imageUrl.isEmpty {
                self.getEventImage(url: imageUrl)
            } else {
                self.eventImage.image = UIImage()
            }
        }
    }
    
    func getEventImage(url: String) {
        Alamofire.request(url).responseData { response in
            if let eventPicture = response.result.value {
                self.eventImage.image = UIImage(data: eventPicture)
            }
        }
    }
}
