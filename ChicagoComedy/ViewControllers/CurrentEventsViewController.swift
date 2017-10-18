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
    var refreshControl = UIRefreshControl()
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.estimatedRowHeight = 100
        table.rowHeight = UITableViewAutomaticDimension
        
        let logo = UIImage(named: "mbtlogo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        self.refreshControl.addTarget(self, action: #selector(self.refreshEvents), for: UIControlEvents.valueChanged)
        self.table?.addSubview(refreshControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getEvents()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEventDetail" {
            if let eventViewController = segue.destination as? EventDetailsTableViewController {
                eventViewController.event = sender as? NSDictionary
            }
        }
    }
    
    @objc func refreshEvents(sender: AnyObject?){
        getEvents()
    }
    
    func getEvents(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        EventAPIClient.sharedInstance.getCurrentEvents().then { result -> Void in
            self.events = result
            self.table.reloadData()
        }.always {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if self.refreshControl.isRefreshing
            {
                self.refreshControl.endRefreshing()
            }
        }.catch { error in
            print(error)
        }
    }
    
    @IBAction func menuWasTapped(_ sender: Any) {
        print("was tapped")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
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
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "ShowEventDetail", sender: events[indexPath.row])
    }
}
