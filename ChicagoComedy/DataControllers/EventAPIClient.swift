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

class EventAPIClient {
    static let sharedInstance = EventAPIClient()
    
    func getCurrentEvents() -> Promise<[NSDictionary]>{
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
                    fulfill(json)
                } else {
                    reject(NSError(domain: "", code: 500, userInfo: nil))
                }
            })
        }
    }
}
