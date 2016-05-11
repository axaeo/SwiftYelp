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
    var displayPhone: String?
    var rating: Float?
    var reviewCount: Int?
    var snippetText: String?
    
    var claimed: Bool?
    var closed: Bool?
    
    var mobileUrl: String?
    var image: UIImage?
    var ratingImage: UIImage?
    
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
        
        result.serverId = json["id"] as? String
        result.name = json["name"] as? String
        result.displayPhone = json["display_phone"] as? String
        result.rating = json["rating"] as? Float
        result.reviewCount = json["review_count"] as? Int
        result.snippetText = json["snippet_text"] as? String
        
        result.mobileUrl = json["mobile_url"] as? String
        
        let yelpCommunicator = AppDelegate.instance().yelpCommunicator!
        yelpCommunicator.downloadImageFromURL((json["image_url"] as? String)!, callback: {(image, error) in
            if (image != nil) {
                result.image = image;
            }
        })
        
        yelpCommunicator.downloadImageFromURL((json["image_url"] as? String)!, callback: {(image, error) in
            if (image != nil) {
                result.ratingImage = image;
            }
        })
        
        result.claimed = json["is_claimed"] as? Bool
        result.closed = json["is_closed"] as? Bool
        
        result.categories = Business.processCategoriesArray(json["categories"] as! Array<AnyObject>)
        result.location = Location.fromJson(json["location"] as! Dictionary<String, AnyObject>)
        
        return result;
    }
    
    class func processCategoriesArray(array: Array<AnyObject>) -> Array<String> {
        var result = Array<String>()
        
        for item in array {
            result.append(item[0] as! String)
        }
        
        return result
    }
    
}
