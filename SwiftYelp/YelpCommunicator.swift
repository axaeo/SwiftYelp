//
//  YelpCommunicator.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-10.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit
import OAuthSwift

class YelpCommunicator {
    
    var client: OAuthSwiftClient?
    
    init(consumerKey:String, consumerSecret:String, accessToken:String, accessTokenSecret:String) {
        client = OAuthSwiftClient(
            consumerKey: consumerKey,
            consumerSecret: consumerSecret,
            accessToken: accessToken,
            accessTokenSecret: accessTokenSecret
        )
    }
    
    func searchWithTerm(term: String, location: String, callback: (data: Array<Business>?, error: ErrorType?) -> Void) {
        client?.get(
            "https://api.yelp.com/v2/search",
            parameters: [
                "term" : term,
                "location" : location,
                "limit" : 10
            ],
            success: { (data, response) in
                do {
                    let resultJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                    let businessJSONArray = resultJSON["businesses"]
                    callback(data: Business.fromArray(businessJSONArray as! Array<Dictionary<String, AnyObject>> ), error: nil);
                } catch  {
                    print("error: %@", error);
                    callback(data: nil, error: error);
                }
            },
            failure: { (error) in
                print("error: %@", error);
                callback(data: nil, error: error);
            }
        )
    }
    
    func getAdditionalDataForBusiness(business: Business, callback: (error: ErrorType?) -> Void) {
    
        let url = String(format:"https://api.yelp.com/v2/business/%@", business.serverId!)
        client?.get(
            url,
            parameters: [:],
            success: { (data, response) in
                do {
                    let resultJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                    let result = Business.fromJson(resultJSON as! Dictionary<String, AnyObject>)
                    business.reviews = result.reviews
                    callback(error: nil)
                } catch  {
                    callback(error: error);
                }
            },
            failure: { (error) in
                callback(error: error);
            }
        )
    }
    
    func downloadDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func downloadImageFromURL(urlString: String, callback: ((image: UIImage?, error: NSError?) -> Void)){
        self.downloadDataFromUrl(NSURL(string: urlString)!) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                callback(image: UIImage(data: data), error: error)
            }
        }
    }

}
