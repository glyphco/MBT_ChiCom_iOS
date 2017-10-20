//
//  ContainerViewController.swift
//  ChicagoComedy
//
//  Created by ARO on 10/17/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import UIKit

class ContainerVeiwController: UIViewController {
    
    @IBOutlet var sideMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var overlayView: UIView!
    
    var sideMenuVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    @IBAction func tappedOverlay(_ sender: Any) {
        toggleSideMenu()
    }
    
    @objc func toggleSideMenu(){
        if sideMenuVisible {
            //hide menu
            sideMenuLeadingConstraint.constant = -250
            sideMenuVisible = false
        } else {
            //show menu
            sideMenuLeadingConstraint.constant = 0
            sideMenuVisible = true
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            if self.sideMenuVisible {
                //show overlay
                self.overlayView.alpha = 0.6
            } else {
                //hide overlay
                self.overlayView.alpha = 0
            }
        }
    }
}
