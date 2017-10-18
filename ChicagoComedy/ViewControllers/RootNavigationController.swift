//
//  RootNavigationController.swift
//  ChicagoComedy
//
//  Created by ARO on 10/6/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import UIKit

class RootNavigationController: UINavigationController {
    override func viewDidLoad() {
//        UIApplication.shared.statusBarStyle = .lightContent
//        //UIApplication.shared.isStatusBarHidden = true
//        print("wass uppppp")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showAboutUs),
                                               name: NSNotification.Name("ShowAboutUs"),
                                               object: nil)
    }
    
    @objc func showAboutUs(){
        performSegue(withIdentifier: "ShowAboutUs", sender: nil)
    }
}
