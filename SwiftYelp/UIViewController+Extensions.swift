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
}
