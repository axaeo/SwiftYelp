//
//  Business.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-10.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit

class Business {

    var serverId: String?
    var name: String?
    var rating: String?
    var reviewCount: String?
    var snippetText: String?
    
    var claimed: String?
    var closed: String?
    
    var mobileUrl: String?
    var imageUrl: String?
    var ratingImageUrl: String?
    var ratingImageLargeUrl: String?
    var snippetImageUrl: String?
    
    var categories: Array<String>?
    var location: Location?
    
    class func fromArray(array: Array<Dictionary<String, AnyObject>>) -> Array<Business> {
        var result = Array<Business>()
        
        for json in array {
            result.append(Business.fromJson(json))
        }
        
        return result;
    }
    
    class func fromJson(json: Dictionary<String, AnyObject>) -> Business {
        let result = Business()
        
        result.serverId = json["server_id"] as? String
        
        return result;
    }
    
}
