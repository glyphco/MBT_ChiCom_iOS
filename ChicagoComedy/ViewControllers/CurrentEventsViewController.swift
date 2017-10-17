//
//  CurrentEventsViewController.swift
//  ChicagoComedy
//
//  Created by ARO on 10/6/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import UIKit

class CurrentEventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    var events:[NSDictionary] = []

    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.estimatedRowHeight = 100
        table.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        EventAPIClient.sharedInstance.getCurrentEvents().then { result -> Void in
            self.events = result
            self.table.reloadData()
        }.catch { error in
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEventDetail" {
            if let eventViewController = segue.destination as? EventDetailsTableViewController {
                eventViewController.event = sender as? NSDictionary
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)  as? EventCell else {
            fatalError("Could not get event cell")
        }
        let event = events[indexPath.row]
        cell.event = event
        if let imageUrl = event.value(forKey: "imageSm") as? String, !imageUrl.isEmpty {
            ImageCacheManager.shared.getImage(url: imageUrl).then { image -> Void in
                cell.eventImage.image = image
            }.catch {error in
                print(error)
            }
        } else {
            cell.eventImage.image = UIImage()
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 81
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowEventDetail", sender: events[indexPath.row])
    }
}
