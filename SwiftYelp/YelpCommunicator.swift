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
    
    init() {
        client = OAuthSwiftClient(
            consumerKey: "aRoBgL5-zphoD2SFRhKRzQ",
            consumerSecret: "rqT2Kup5KmtDLlgL72dr1NEn0to",
            accessToken: "ftHUQK527kQ4WJCeFD0qsJZ4SKn2M8eO",
            accessTokenSecret: "2Yp-ARyUPm-CEnH-IHv5Ez2uN_8"
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

}
