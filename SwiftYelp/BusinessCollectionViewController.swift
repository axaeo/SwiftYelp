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
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false);
        self.collectionView?.reloadData()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.businessSearchResults?.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! BusinessCollectionViewCell
        
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
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! BusinessCollectionHeaderView
        header.label.text = String(format: "Searched for: %@", searchedTerm!)
        header.delegate = self;
        
        let gesture = UITapGestureRecognizer(target: header, action: #selector(BusinessCollectionHeaderView.onTap))
        gesture.delaysTouchesBegan = true;
        gesture.numberOfTapsRequired = 1;
        header.addGestureRecognizer(gesture)
        
        return header;
    }
    
    func didTapHeader(_ sender: BusinessCollectionHeaderView) {
        self.businessSearchResults = self.businessSearchResults?.reversed()
        self.collectionView?.reloadData()
        sender.imageView.transform = sender.imageView.transform.concatenating(CGAffineTransform(scaleX: 1, y: -1));
    }
    
    func businessForIndexPath(_ indexPath: IndexPath) -> Business {
        return self.businessSearchResults![(indexPath as NSIndexPath).row]
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBusiness = self.businessForIndexPath(indexPath);
        self.showActivityIndicator { (spinner) in
            AppDelegate.instance().yelpCommunicator!.getAdditionalDataForBusiness(selectedBusiness, callback: {(error) in
                    spinner.removeFromSuperview()
                    if (error == nil) {
                        self.selectedIndexPath = indexPath;
                        DispatchQueue.main.async(execute: {
                            self.performSegue(withIdentifier: detailSegueID, sender: self)
                        })
                    } else {
                        self.showErrorMessage("Could not retrieve business details", title: "Connnection Error")
                    }
            })
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == detailSegueID) {
            let destination:BusinessViewController = segue.destination as! BusinessViewController
            destination.business = self.businessForIndexPath(self.selectedIndexPath!)
        }
    }

}
