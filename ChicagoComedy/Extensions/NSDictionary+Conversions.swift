//
//  NSDictionary+Conversions.swift
//  ChicagoComedy
//
//  Created by ARO on 10/23/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation

extension NSDictionary {
    static func toString(data: NSDictionary) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            if let json = String(data: jsonData, encoding: .utf8) {
                return json
            }
        } catch {
            //LOG AN ERROR HERE
            //fatalError("Couldnt convert event json to string")
            return ""
        }
        return ""
    }
}
