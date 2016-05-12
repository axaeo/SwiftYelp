//
//  thing.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-12.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit

extension UIViewController {

    func showErrorMessage(message:String, title:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicator(completion: (spinner:UIActivityIndicatorView) -> Void) {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        spinner.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
        spinner.hidesWhenStopped = true;
        spinner.hidden = true;
        self.view.bringSubviewToFront(spinner)
        self.view.addSubview(spinner)
        spinner.startAnimating()
        
        dispatch_async(dispatch_get_main_queue(),{
            completion(spinner: spinner);
        })
    }
}
