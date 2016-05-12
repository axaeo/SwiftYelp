//
//  AppDelegate.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-10.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var yelpCommunicator: YelpCommunicator?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        //WARNING: - Incomplete implementation. Ensure values are placed in plist!
        let path = NSBundle.mainBundle().pathForResource("YelpAPI", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        let consumerKey = dict!.valueForKey("consumerKey") as? String
        let consumerSecret = dict!.valueForKey("consumerSecret") as? String
        let accessToken = dict!.valueForKey("accessToken") as? String
        let accessTokenSecret = dict!.valueForKey("accessTokenSecret") as? String
        
        self.yelpCommunicator = YelpCommunicator(consumerKey: consumerKey!, consumerSecret: consumerSecret!, accessToken: accessToken!, accessTokenSecret: accessTokenSecret!);
        
        return true
    }
    
    class func instance() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
}

