//
//  Review.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-12.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit

class Review {
    
    var serverId:String?
    var rating:Int?
    var ratingImageUrl:String?
    var excerpt:String?
    var timestamp:Int?
    var authorName:String?
    
    class func fromArray(_ array: Array<AnyObject>) -> Array<Review> {
        var result = Array<Review>()
        
        for json in array {
            result.append(Review.fromJson(json as! Dictionary<String, AnyObject>))
        }
        
        return result;
    }
    
    class func fromJson(_ json:Dictionary<String, AnyObject>) -> Review {
        let result:Review = Review()
        
        result.serverId = json["id"] as? String
        result.rating = json["rating"] as? Int
        result.ratingImageUrl = json["rating_image_large_url"] as? String
        result.excerpt = json["excerpt"] as? String
        result.timestamp = json["time_created"] as? Int
        result.authorName = json["user"]!["name"] as? String
        
        return result
    }
}
