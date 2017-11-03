//
//  Event.swift
//  ChicagoComedy
//
//  Created by ARO on 10/20/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import ObjectMapper

class Event: Mappable {
    var name:String?
    var description:String?
    var venueName:String?
    var streetAddress:String?
    var lat:String?
    var lng:String?
    var imageUrl:String?
    var imageIcon:String?
    var imageSm:String?
    var imageLg:String?
    var agesWord:String?
    var localStart:Date?
    var localStartTime:String?
    var localEndTime:String?
    var localTimes:String?
    var localStartDate:String?
    var localEndDate:String?
    var priceWord:String?
    var priceMinMax:String?
    var participants: [Participant] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        description <- map["description"]
        venueName <- map["venue_name"]
        streetAddress <- map["street_address"]
        lat <- map["lat"]
        lng <- map["lng"]
        imageUrl <- map["imageurl"]
        imageIcon <- map["imageIcon"]
        imageSm <- map["imageSm"]
        imageLg <- map["imageLg"]
        agesWord <- map["agesWord"]
        if let localStartString = map.JSON["local_start"] as? String {
            self.localStart = Date.parseDateFrom(string: localStartString)
        } else {
            self.localStart = nil
        }
        localStartTime <- map["localstarttime"]
        localEndTime <- map["localendtime"]
        localTimes <- map["localtimes"]
        localStartDate <- map["localstartdate"]
        localEndDate <- map["localenddate"]
        priceWord <- map["priceWord"]
        priceMinMax <- map["priceMinMax"]
        if let participantsString = map.JSON["participantsjson"] as? String, let participantsJson = NSDictionary.toDictionary(text: participantsString) {
            for json in participantsJson {
                let jsonString = NSDictionary.toString(data:json) ?? ""
                if let participant = Mapper<Participant>().map(JSONString: jsonString) {
                    self.participants.append(participant)
                }
            }
        }
    }
}
