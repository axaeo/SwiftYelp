//
//  BusinessViewController.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-11.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit
import MapKit

class BusinessViewController: UIViewController {

    var business:Business?
    var latestReview:Review?
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var closedLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var reviewAuthorLabel: UILabel!
    
    override func viewDidLoad() {
        self.restaurantImageView.layer.cornerRadius = 5
        self.restaurantImageView.layer.borderWidth = 2;
        self.restaurantImageView.layer.borderColor = UIColor(colorLiteralRed: 182/255, green: 56/255, blue: 34/255, alpha: 1).cgColor
        self.restaurantImageView.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = business?.name
        addressLabel.text = business?.location?.displayAddress![0]
        reviewCountLabel.text = String(format: "Based on %d reviews", (business?.reviewCount)!)
        
        self.styleClosedLabel((business?.closed)!)
        
        AppDelegate.instance().yelpCommunicator!.downloadImageFromURL((business?.imageUrl)!, callback: {(image, error) in
            if (image != nil) {
                self.restaurantImageView.image  = image
            }
        })
        
        AppDelegate.instance().yelpCommunicator!.downloadImageFromURL((business?.ratingImageUrl)!, callback: {(image, error) in
            if (image != nil) {
                self.ratingImageView.image = image
            }
        })
        
        if (business!.reviews!.count > 0) {
            self.latestReview = business?.reviews![0]
            self.reviewLabel.text = latestReview?.excerpt
            self.reviewAuthorLabel.text = latestReview?.authorName
            AppDelegate.instance().yelpCommunicator!.downloadImageFromURL((latestReview?.ratingImageUrl)!, callback: {(image, error) in
                if (image != nil) {
                    self.reviewImageView.image = image
                }
            })
        } else {
            self.reviewLabel.text = "No reviews."
            self.reviewAuthorLabel.isHidden = true;
            self.reviewImageView.isHidden = true;
        }
        
    }
    
    func styleClosedLabel(_ isClosed:Bool) {
        if (isClosed) {
            self.closedLabel.text = "Closed"
        } else {
            self.closedLabel.text = "Open"
        }
    }
    
    @IBAction func callButtonPressed(_ sender: UIButton) {
        if let phoneNumber = business?.phone {
            UIApplication.shared.openURL(URL(string: String(format:"tel://%@", phoneNumber))!)
        }
    }
    
    @IBAction func mapsButtonPressed(_ sender: UIButton) {
        let lat:CLLocationDegrees = (business?.location?.latitude)!
        let lng:CLLocationDegrees = (business?.location?.longitude)!
        
        let coordinate = CLLocationCoordinate2DMake(lat,lng)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = business?.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeDriving : MKLaunchOptionsDirectionsModeKey])
    }
    
    @IBAction func seeMorePressed(_ sender: UIButton) {
        if let url = business?.mobileUrl {
            UIApplication.shared.openURL(URL(string:(url))!)
        }
    }
}
