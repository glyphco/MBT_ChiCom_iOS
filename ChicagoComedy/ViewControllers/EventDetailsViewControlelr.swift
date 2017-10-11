//
//  EventDetailsViewControlelr.swift
//  ChicagoComedy
//
//  Created by ARO on 10/6/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
//import AlamofireIamge

class EventDetailsViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var eventDescriptionTextView: UITextView!
    @IBOutlet var viewHeightContraint: NSLayoutConstraint!
    @IBOutlet var contentView: UIView!
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
        if let imageUrl = event?.value(forKey: "imageSm") as? String {
            setEventImage(url: imageUrl)
        }
        let newHeight = getContentHeight()
        viewHeightContraint.constant = newHeight
    }
    
    func setEventImage(url: String){
        Alamofire.request(url).responseData { response in
            if let eventPicture = response.result.value {
                self.eventImage.image = UIImage(data: eventPicture)
            }
        }
    }
    
    func getContentHeight()->CGFloat{
        let descriptionHeight = eventDescriptionTextView.frame.size.height
        return descriptionHeight + CGFloat(200)
    }
    
}
