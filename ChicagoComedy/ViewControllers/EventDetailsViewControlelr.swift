//
//  EventDetailsViewControlelr.swift
//  ChicagoComedy
//
//  Created by ARO on 10/6/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import UIKit

class EventDetailsViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var eventDescriptionTextView: UITextView!
    @IBOutlet var viewHeightContraint: NSLayoutConstraint!
    @IBOutlet var contentView: UIView!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var venueLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    var event: NSDictionary?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = event?.value(forKey: "name") as? String
        venueLabel.text = event?.value(forKey: "venue_name") as? String
        addressLabel.text = event?.value(forKey: "street_address") as? String
        eventDescriptionTextView.text = event?.value(forKey: "description") as? String
        eventDescriptionTextView.sizeToFit()
        descriptionView.frame.size.height = eventDescriptionTextView.frame.size.height
        if let imageUrl = event?.value(forKey: "imageSm") as? String {
            setEventImage(imageUrl: imageUrl)
        }
        let newHeight = getContentHeight()
        viewHeightContraint.constant = newHeight
    }
    
    func setEventImage(imageUrl: String){
        ImageCacheManager.shared.getImage(url: imageUrl).then { image -> Void in
            self.eventImage.image = image
        }.catch {error in
            print(error)
        }
    }
    
    func getContentHeight()->CGFloat{
        let descriptionHeight = eventDescriptionTextView.frame.size.height
        return descriptionHeight + CGFloat(200)
    }
    
}
