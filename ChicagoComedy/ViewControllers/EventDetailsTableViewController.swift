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
import MapKit

class EventDetailsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var event: Event?
    var descriptionHeight = CGFloat(100)
    
    override func viewDidLoad() {
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    @IBAction func imageTapped(_ sender: Any) {
        performSegue(withIdentifier: "ShowOriginalImage", sender: self.event)
    }
    
    @IBAction func mapButtonTapped(_ sender: Any) {
        if let lat = event?.lat, let lng = event?.lng,
            !lat.isEmpty, !lng.isEmpty, let latitude = Double(lat), let longitude = Double(lng)  {
            openMapForPlace(lat: latitude, lng: longitude)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ImageContainerViewController {
            controller.event = event
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: //header
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventHeaderCell", for: indexPath) as? EventHeaderCell else {
                fatalError("Could not setup event header")
            }
            if let imageLink = event?.imageSm, !imageLink.isEmpty {
                ImageCacheManager.shared.getImage(url: imageLink).then { image -> Void in
                    cell.eventImageView.image = image
                }.catch { error in
                    print(error)
                }
            } else {
                cell.eventImageView.image = UIImage(named: "event-default")
            }
            
            cell.eventNameLabel.text = event?.name
            cell.eventVenueLabel.text = event?.venueName
            cell.eventAddressLabel.text = event?.streetAddress
            return cell
        case 1: //details
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventInfoCell", for: indexPath) as? EventInfoCell else {
                fatalError("Could not setup event header")
            }
            cell.event = event
            return cell
        case 2 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantsCell", for: indexPath) as? ParticipantsCell else {
                fatalError("Could not setup participants cell")
            }
            cell.participants = event?.participants ?? []
            return cell
        default: //description
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventDescriptionCell", for: indexPath) as? EventDescriptionCell else {
                fatalError("Could not setup event description")
            }
            if let description = event?.description, !description.isEmpty {
                cell.eventDescriptionTextView.text = description
            } else {
               cell.eventDescriptionTextView.text = "No description available."
            }
            cell.eventDescriptionTextView.sizeToFit()
            self.descriptionHeight = cell.eventDescriptionTextView.frame.size.height + 46
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 192
        case 1:
            return 106
        case 2:
            return 100
        default:
            return descriptionHeight
        }
    }
    
    func openMapForPlace(lat: Double, lng: Double) {
        
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = lng
        
        let regionDistance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = event?.venueName
        mapItem.openInMaps(launchOptions: options)
    }
    
}
