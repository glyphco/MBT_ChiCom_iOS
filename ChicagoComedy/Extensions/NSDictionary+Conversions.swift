//
//  NSDictionary+Conversions.swift
//  ChicagoComedy
//
//  Created by ARO on 10/23/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation

extension NSDictionary {
    static func toString(data: NSDictionary) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            if let json = String(data: jsonData, encoding: .utf8) {
                return json
            }
        } catch {
            //LOG AN ERROR HERE
            print("Couldnt convert event json to string")
        }
        return nil
    }
    
    static func toDictionary(text: String) -> [NSDictionary]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
