//
//  BusinessViewController.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-11.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit

class BusinessViewController: UIViewController {

    var business:Business?
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var closedLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        self.title = business?.name
        addressLabel.text = business?.location?.displayAddress![0]
        
        AppDelegate.instance().yelpCommunicator!.downloadImageFromURL((business?.imageUrl)!, callback: {(image, error) in
            if (image != nil) {
                self.restaurantImageView.image  = image
            }
        })
        
        AppDelegate.instance().yelpCommunicator!.downloadImageFromURL((business?.ratingImageUrl)!, callback: {(image, error) in
            if (image != nil) {
                self.reviewImageView.image = image
            }
        })
        
    }
    @IBAction func callButtonPressed(sender: UIButton) {
    }
    
    @IBAction func mapsButtonPressed(sender: UIButton) {
    }
    
    @IBAction func seeMorePressed(sender: UIButton) {
    }
}
