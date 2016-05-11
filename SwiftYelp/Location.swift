//
//  Location.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-10.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit

class Location  {

    var displayAddress:Array<String>?
    var neighborhoods:Array<String>?
    var latitude:Float?
    var longitude:Float?
    
    class func fromJson(json: Dictionary<String, AnyObject>) -> Location {
        let result = Location()
        
        result.displayAddress = json["display_address"] as? Array<String>
        result.neighborhoods = json["neighborhoods"] as? Array<String>
        result.latitude = json["coordinate"]?["longitude"] as? Float
        result.longitude = json["coordinate"]?["longitude"] as? Float
        
        return result;
    }
    
}
