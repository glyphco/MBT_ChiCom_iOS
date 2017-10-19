//
//  ImageViewerViewController.swift
//  ChicagoComedy
//
//  Created by ARO on 10/19/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import UIKit

class ImageViewerViewController: UIViewController {
    var event: NSDictionary?
    @IBOutlet var loadingIdicator: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        if let imageUrl = event?.value(forKey: "imageurl") as? String, !imageUrl.isEmpty {
            getImage(imageUrl: imageUrl)
        } else {
            self.imageView.image = UIImage(named: "event-default")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingIdicator.isHidden = true
    }
    
    func getImage(imageUrl: String){
        loadingIdicator.isHidden = false
        ImageCacheManager.shared.getImage(url: imageUrl, cost: 3).then { image -> Void in
            self.imageView.image = image
        }.always {
            self.loadingIdicator.isHidden = true
        }.catch {error in
            print(error)
        }
    }
}
