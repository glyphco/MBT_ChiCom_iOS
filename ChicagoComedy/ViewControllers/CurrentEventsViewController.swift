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
    
    var events:[Event] = []
    var refreshControl = UIRefreshControl()
    
    @IBOutlet var table: UITableView!
    var customView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.estimatedRowHeight = 100
        table.rowHeight = UITableViewAutomaticDimension
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showAboutUs),
                                               name: NSNotification.Name("ShowAboutUs"),
                                               object: nil)
        
        let logo = UIImage(named: "mbtlogo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        self.refreshControl.addTarget(self, action: #selector(self.refreshEvents), for: UIControlEvents.valueChanged)
        self.table?.addSubview(refreshControl)
        loadCustomRefreshContents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getEvents()
    }
    
    @objc func showAboutUs(){
        performSegue(withIdentifier: "ShowAboutUs", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEventDetail" {
            if let eventViewController = segue.destination as? EventDetailsTableViewController {
                eventViewController.event = sender as? Event
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
        if let imageUrl = event.imageSm, !imageUrl.isEmpty {
            ImageCacheManager.shared.getImage(url: imageUrl).then { image -> Void in
                DispatchQueue.main.async(execute: {() -> Void in
                    let updateCell = self.table.cellForRow(at: indexPath) as? EventCell
                    if updateCell != nil {
                        updateCell?.eventImage.image = image
                    }
                })
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
    
    func loadCustomRefreshContents() {
        let refreshContents = Bundle.main.loadNibNamed("RefreshContents", owner: self, options: nil)
        customView = refreshContents![0] as! UIView
        customView.frame = refreshControl.bounds
        refreshControl.addSubview(customView)
    }
}
