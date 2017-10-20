//
//  EventAPIClient.swift
//  ChicagoComedy
//
//  Created by ARO on 10/6/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import ObjectMapper

class EventAPIClient {
    static let sharedInstance = EventAPIClient()
    
    func getCurrentEvents() -> Promise<[Event]>{
        return Promise {fulfill, reject in
//            let root = "https://api.myboringtown.com/api/public/events/today"
            let root = "https://api.myboringtown.com/api/chicagocomedy/events"
//            let lat = "41.818408221760095"
//            let lng = "-87.81646728515625"
//            let dist = "38624.159999999996"
//            let tz = "America/Chicago"
//            let path = "\(root)?lat=\(lat)&lng=\(lng)&dist=\(dist)&tz=\(tz)"
            let path = root
            Alamofire.request(path, method: HTTPMethod.get).validate().responseJSON(completionHandler: { (response) in
                if let error = response.result.error {
                    reject(error)
                } else if let json = response.result.value as? [NSDictionary] {
                    var events:[Event] = []
                    for eventJson in json {
                        if let event = Mapper<Event>().map(JSONString: self.dictionaryToString(data: eventJson)) {
                            events.append(event)
                        }
                    }
                    fulfill(events)
                } else {
                    reject(NSError(domain: "", code: 500, userInfo: nil))
                }
            })
        }
    }
    
    func dictionaryToString(data: NSDictionary)->String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            if let json = String(data: jsonData, encoding: .utf8) {
                return json
            }
        } catch {
            //LOG AN ERROR HERE
            fatalError("Couldnt convert event json to string")
        }
        return ""
    }
}
