//
//  MenuViewController.swift
//  ChicagoComedy
//
//  Created by ARO on 10/18/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        if let window = UIApplication.shared.keyWindow {
            window.windowLevel = UIWindowLevelStatusBar + 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AboutUsCell", for: indexPath) else {
//            fatalError("Could not get about us cell")
//        }
        return tableView.dequeueReusableCell(withIdentifier: "AboutUsCell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        switch indexPath.row {
        case 0:
            NotificationCenter.default.post(name: NSNotification.Name("ShowAboutUs"), object: nil)
        default:
            break
        }
    }
    
}
