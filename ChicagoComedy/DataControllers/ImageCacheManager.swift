//
//  ImageCacheManager.swift
//  ChicagoComedy
//
//  Created by ARO on 10/16/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import UIKit
import PromiseKit
import Alamofire

class ImageCacheManager {
    let cache = NSCache<NSString, UIImage>()
    static let shared = ImageCacheManager()
    
    private init() {
        cache.name = "ImageCache"
        cache.totalCostLimit = 100
    }
    
    func getImage(url: String, cost:Int=1)->Promise<UIImage> {
        return Promise {fulfill, reject in
            if let cachedVersion = cache.object(forKey: url as NSString) {
                fulfill(cachedVersion)
            } else {
                Alamofire.request(url).responseData { response in
                    if let eventPicture = response.result.value {
                        if let picture = UIImage(data: eventPicture) {
                            self.cache.setObject(picture, forKey: url as NSString, cost: cost)
                            fulfill(picture)
                        } else {
                            //image data not correct
                            reject(NSError(domain: "", code: 422, userInfo: nil))
                        }
                    }
                }
            }
        }
    }
}
