//
//  Participant.swift
//  ChicagoComedy
//
//  Created by ARO on 10/21/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import ObjectMapper

class Participant: Mappable {
    var name: String?
    var start: String?
    var imageUrl: String?
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        name <- map["name"]
        start <- map["start"]
        imageUrl <- map["imageurl"]
    }
    
}
