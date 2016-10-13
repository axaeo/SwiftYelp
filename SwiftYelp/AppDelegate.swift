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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        //WARNING: - Incomplete implementation. Ensure values are placed in plist!
        let path = Bundle.main.path(forResource: "YelpAPI", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        let consumerKey = dict!.value(forKey: "consumerKey") as? String
        let consumerSecret = dict!.value(forKey: "consumerSecret") as? String
        let accessToken = dict!.value(forKey: "accessToken") as? String
        let accessTokenSecret = dict!.value(forKey: "accessTokenSecret") as? String
        
        self.yelpCommunicator = YelpCommunicator(consumerKey: consumerKey!, consumerSecret: consumerSecret!, accessToken: accessToken!, accessTokenSecret: accessTokenSecret!);
        
        return true
    }
    
    class func instance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
}

