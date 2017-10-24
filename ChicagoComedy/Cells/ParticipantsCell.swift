//
//  ParticipantsCell.swift
//  ChicagoComedy
//
//  Created by ARO on 10/20/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import UIKit

class ParticipantsCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    var numRows = 0;

    @IBOutlet var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet var table: UITableView!
    var participants: [Participant] = [] {
        didSet {
            numRows = 0
            table.dataSource = self
            table.delegate = self
            table.estimatedRowHeight = 30
            table.rowHeight = UITableViewAutomaticDimension
            
            table.reloadData()
            table.layoutIfNeeded()
            tableHeightConstraint.constant = table.contentSize.height
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participants.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantCell", for: indexPath) as? ParticipantCell else {
            fatalError("Could not setup participant cell")
        }
        cell.nameLabel.text = participants[indexPath.row].name
        cell.timeLabel.text = participants[indexPath.row].start ?? ""
        if let imageUrl = participants[indexPath.row].imageUrl, !imageUrl.isEmpty {
            ImageCacheManager.shared.getImage(url: imageUrl, cost: 3).then {image -> Void in
                DispatchQueue.main.async(execute: {() -> Void in
                    let updateCell = self.table.cellForRow(at: indexPath) as? ParticipantCell
                    if updateCell != nil {
                        updateCell?.participantImage.image = image
                    }
                })
            }.catch { error in
                print(error.localizedDescription)
            }
        } else {
            cell.participantImage.image = UIImage()
        }
        
        return cell
    }
}
