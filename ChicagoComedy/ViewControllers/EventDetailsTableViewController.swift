//
//  EventDetailsTableViewController.swift
//  ChicagoComedy
//
//  Created by ARO on 10/12/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import PromiseKit

class EventDetailsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var event: NSDictionary?
    var descriptionHeight = CGFloat(100)
    
    override func viewDidLoad() {
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: //header
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventHeaderCell", for: indexPath) as? EventHeaderCell else {
                fatalError("Could not setup event header")
            }
            let imageLink = event?.value(forKey: "imageLg") as? String
            setEventImage(url: imageLink ?? "").then { image -> Void in
                cell.eventImageView.image = image
            }
            cell.eventNameLabel.text = event?.value(forKey: "name") as? String
            cell.eventVenueLabel.text = event?.value(forKey: "venue_name") as? String
            cell.eventAddressLabel.text = event?.value(forKey: "street_address") as? String
            let startTime = (event?.value(forKey: "localstarttime") as? String) ?? ""
            let startDate = (event?.value(forKey: "localstartdate") as? String) ?? ""
            cell.startTimeLabel.text = "\(startDate) \(startTime)"
            return cell
        case 1: //details
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventInfoCell", for: indexPath) as? EventInfoCell else {
                fatalError("Could not setup event header")
            }
            
            let price = event?.value(forKey: "priceWord") as? String ?? ""
            let priceMinMax = event?.value(forKey: "priceMinMax") as? String ?? ""
            let priceString = [price, priceMinMax].joined(separator: " ")
            if(!price.isEmpty || !priceMinMax.isEmpty){
                cell.priceLabel.text = priceString.trimmingCharacters(in: .whitespaces)
                cell.priceView.isHidden = false
            } else {
                cell.priceView.isHidden = true
            }
            return cell
        default: //description
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventDescriptionCell", for: indexPath) as? EventDescriptionCell else {
                fatalError("Could not setup event description")
            }
            if let description = event?.value(forKey: "description") as? String, !description.isEmpty {
                cell.eventDescriptionTextView.text = description
            } else {
               cell.eventDescriptionTextView.text = "No description available."
            }
            cell.eventDescriptionTextView.sizeToFit()
            self.descriptionHeight = cell.eventDescriptionTextView.frame.size.height + 46
            return cell
        }
    }
    
    func setEventImage(url: String) -> Promise<UIImage> {
        return Promise { fulfill, reject in
            Alamofire.request(url).responseData { response in
                if let eventPicture = response.result.value {
                    fulfill(UIImage(data: eventPicture)!)
                } else {
                    fulfill(UIImage())
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 192
        case 1:
            return 106
        default:
            return descriptionHeight
        }
    }
    
    
}
