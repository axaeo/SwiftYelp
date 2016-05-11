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

class BusinessCollectionViewController: UICollectionViewController {

    var businessSearchResults: Array<Business>?
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
        AppDelegate.instance().yelpCommunicator!.downloadImageFromURL(business.ratingImageUrl!, callback: {(image, error) in
            if (image != nil) {
                 cell.ratingImageView.image = image
            }
        })
       
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, forIndexPath: indexPath) as! BusinessCollectionHeaderView
            header.label.text = String(format: "Searched for: %@", "Ethiopian")
            return header;
    }
    
    func businessForIndexPath(indexPath: NSIndexPath) -> Business {
        return self.businessSearchResults![indexPath.row]
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectedIndexPath = indexPath;
        performSegueWithIdentifier(detailSegueID, sender: self)
    }
    
    //TODO: Header?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == detailSegueID) {
            let destination:BusinessViewController = segue.destinationViewController as! BusinessViewController
            destination.business = self.businessForIndexPath(self.selectedIndexPath!)
        }
    }

}
