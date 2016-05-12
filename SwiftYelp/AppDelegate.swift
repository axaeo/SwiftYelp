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
    
        self.yelpCommunicator = YelpCommunicator();
        
        return true
    }
    
    class func instance() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
}

