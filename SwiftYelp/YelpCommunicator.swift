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
            oauthToken: accessToken,
            oauthTokenSecret: accessTokenSecret,
            version: OAuthSwiftCredential.Version.oauth1
            
        )
    }
    
    func searchWithTerm(_ term: String, location: String, callback: @escaping (_ data: Array<Business>?, _ error: Error?) -> Void) {
        client?.get(
            "https://api.yelp.com/v2/search",
            parameters: [
                "term" : term,
                "location" : location,
                "limit" : 10
            ],
            success: { (data, response) in
                do {
                    let resultJSON = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
                    let businessJSONArray = resultJSON["businesses"]
                    callback(Business.fromArray(businessJSONArray as! Array<Dictionary<String, AnyObject>> ), nil);
                } catch  {
                    print("error: %@", error);
                    callback(nil, error);
                }
            },
            failure: { (error) in
                print("error: %@", error);
                callback(nil, error);
            }
        )
    }
    
    func getAdditionalDataForBusiness(_ business: Business, callback: @escaping (_ error: Error?) -> Void) {
    
        let url = String(format:"https://api.yelp.com/v2/business/%@", business.serverId!)
        client?.get(
            url,
            parameters: [:],
            success: { (data, response) in
                do {
                    let resultJSON = try JSONSerialization.jsonObject(with: data, options: [])
                    let result = Business.fromJson(resultJSON as! Dictionary<String, AnyObject>)
                    business.reviews = result.reviews
                    callback(nil)
                } catch  {
                    callback(error);
                }
            },
            failure: { (error) in
                callback(error);
            }
        )
    }
    
    func downloadDataFromUrl(_ url:URL, completion: @escaping ((_ data: Data?, _ response: URLResponse?, _ error: Error? ) -> Void)) {
    /**    URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            completion(data, response, error)
            }) .resume() **/
        
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImageFromURL(_ urlString: String, callback: @escaping ((_ image: UIImage?, _ error: Error?) -> Void)){
        self.downloadDataFromUrl(URL(string: urlString)!) { (data, response, error)  in
            DispatchQueue.main.async { () -> Void in
                guard let data = data , error == nil else { return }
                callback(UIImage(data: data), error)
            }
        }
    }

}
