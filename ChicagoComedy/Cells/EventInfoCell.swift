//
//  EventInfoCell.swift
//  ChicagoComedy
//
//  Created by ARO on 10/12/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import UIKit

class EventInfoCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var table: UITableView!
    @IBOutlet var tableHeightConstraint: NSLayoutConstraint!
    
    var numRows = 0;
    var tableData = [[String:String]]()
    
    var event: NSDictionary? {
        didSet {
            guard let event = event else {
                return
            }
            table.dataSource = self
            table.delegate = self
            table.estimatedRowHeight = 60
            table.rowHeight = UITableViewAutomaticDimension
            
            let price = event.value(forKey: "priceWord") as? String ?? ""
            let priceMinMax = event.value(forKey: "priceMinMax") as? String ?? ""
            let priceString = [price, priceMinMax].joined(separator: " ")
            if(!price.isEmpty || !priceMinMax.isEmpty){
                tableData.append(["Price":priceString.trimmingCharacters(in: .whitespaces)])
                numRows += 1
            }
            
            if let ages = event.value(forKey: "agesWord") as? String, !ages.isEmpty {
                tableData.append(["Ages":ages])
                numRows += 1
            }

            if let startDate = event.value(forKey: "localstartdate") as? String, !startDate.isEmpty {
                var startTimeString = ""
                if let startTime = event.value(forKey: "localstarttime") as? String, !startTime.isEmpty {
                    startTimeString = "at \(startTime)"
                }
                tableData.append(["Starts":"\(startDate) \(startTimeString)"])
                numRows += 1
            }
            
            if let endDate = event.value(forKey: "localenddate") as? String, !endDate.isEmpty {
                var endTimeString = ""
                if let endTime = event.value(forKey: "localendtime") as? String, !endDate.isEmpty {
                    endTimeString = "at \(endTime)"
                }
                tableData.append(["Ends":"\(endDate) \(endTimeString)"])
                numRows += 1
            }
            
            table.reloadData()
            table.layoutIfNeeded()
            tableHeightConstraint.constant = table.contentSize.height
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell else {
            fatalError("Could not setup info cell")
        }
        
        let title = tableData[indexPath.row].keys.first!
        cell.titleLabel.text = title
        cell.detailsLabel.text = tableData[indexPath.row][title]
        return cell
    }
    
}
