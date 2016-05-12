//
//  BusinessCollectionViewController.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-11.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "BusinessCollectionViewCell"
private let headerReuseIdentifier = "searchHeader"
private let detailSegueID:String = "detail"

class BusinessCollectionViewController: UICollectionViewController, BusinessCollectionHeaderViewDelegate {

    var businessSearchResults: Array<Business>?
    var searchedTerm: String?
    var selectedIndexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false);
        self.collectionView?.reloadData()
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.businessSearchResults?.count)!
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! BusinessCollectionViewCell
        
        let business = self.businessForIndexPath(indexPath);
        cell.nameLabel.text = business.name
        cell.addressLabel.text = business.location!.displayAddress![0]
        AppDelegate.instance().yelpCommunicator!.downloadImageFromURL(business.ratingImageUrl!, callback: {(image, error) in
            if (image != nil) {
                 cell.ratingImageView.image = image
            }
        })
       
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, forIndexPath: indexPath) as! BusinessCollectionHeaderView
        header.label.text = String(format: "Searched for: %@", searchedTerm!)
        header.delegate = self;
        
        let gesture = UITapGestureRecognizer(target: header, action: #selector(BusinessCollectionHeaderView.onTap))
        gesture.delaysTouchesBegan = true;
        gesture.numberOfTapsRequired = 1;
        header.addGestureRecognizer(gesture)
        
        return header;
    }
    
    func didTapHeader(sender: BusinessCollectionHeaderView) {
        self.businessSearchResults = self.businessSearchResults?.reverse()
        self.collectionView?.reloadData()
        sender.imageView.transform = CGAffineTransformConcat(sender.imageView.transform, CGAffineTransformMakeScale(1, -1));
    }
    
    func businessForIndexPath(indexPath: NSIndexPath) -> Business {
        return self.businessSearchResults![indexPath.row]
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedBusiness = self.businessForIndexPath(indexPath);
        self.showActivityIndicator { (spinner) in
            AppDelegate.instance().yelpCommunicator!.getAdditionalDataForBusiness(selectedBusiness, callback: {(error) in
                    spinner.removeFromSuperview()
                    if (error == nil) {
                        self.selectedIndexPath = indexPath;
                        dispatch_async(dispatch_get_main_queue(),{
                            self.performSegueWithIdentifier(detailSegueID, sender: self)
                        })
                    } else {
                        self.showErrorMessage("Could not retrieve business details", title: "Connnection Error")
                    }
            })
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == detailSegueID) {
            let destination:BusinessViewController = segue.destinationViewController as! BusinessViewController
            destination.business = self.businessForIndexPath(self.selectedIndexPath!)
        }
    }

}
