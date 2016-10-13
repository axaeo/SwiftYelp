//
//  thing.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-12.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit

extension UIViewController {

    func showErrorMessage(_ message:String, title:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicator(_ completion: @escaping (_ spinner:UIActivityIndicatorView) -> Void) {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        spinner.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.size.height / 2);
        spinner.hidesWhenStopped = true;
        spinner.isHidden = true;
        self.view.bringSubview(toFront: spinner)
        self.view.addSubview(spinner)
        spinner.startAnimating()
        
        DispatchQueue.main.async(execute: {
            completion(spinner);
        })
    }
}
