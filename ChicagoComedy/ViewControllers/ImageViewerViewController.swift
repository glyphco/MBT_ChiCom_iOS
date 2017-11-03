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
    var event: Event?
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingIndicator.isHidden = true
        if let imageUrl = event?.imageUrl, !imageUrl.isEmpty {
            loadingIndicator.isHidden = false
            getImage(imageUrl: imageUrl)
        } else {
            self.imageView.image = UIImage(named: "event-default")
        }
    }
    
    func getImage(imageUrl: String){
        print("tried to get image")
        ImageCacheManager.shared.getImage(url: imageUrl, cost: 3).then { image -> Void in
            self.imageView.image = image
        }.always {
            self.loadingIndicator.isHidden = true
        }.catch {error in
            print(error)
        }
    }
}
