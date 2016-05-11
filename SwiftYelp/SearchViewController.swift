//
//  SearchViewController.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-10.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let searchSegueID:String = "search"
    
    var businessSearchResults: Array<Business>?
    
    @IBOutlet weak var searchField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false);
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == searchSegueID {
            let searchResultVC:BusinessCollectionViewController = segue.destinationViewController as! BusinessCollectionViewController
            searchResultVC.businessSearchResults = self.businessSearchResults;
            searchResultVC.searchedTerm = self.searchFieldContents()
        }
    }
    
    func showResultsPage() {
        self.performSegueWithIdentifier(searchSegueID, sender: self)
    }
    
    @IBAction func submitSearch(sender: UIButton) {
        
        let searchTerm = self.searchFieldContents()
        
        if searchTerm!.isEmpty {
            //TODO show error
            return
        }
        
        AppDelegate.instance()
            .yelpCommunicator!.searchWithTerm(searchTerm!,
                                                location: "Toronto",
                                                callback: {(data, error) in
                                                    if (data != nil) {
                                                        self.businessSearchResults = data!.sort{ $0.name < $1.name }
                                                        dispatch_async(dispatch_get_main_queue(),{
                                                            self.showResultsPage()
                                                        })
                                                    } else {
                                                        //TODO show error message
                                                    }
                                                })
        
    }
    
    func searchFieldContents() -> String? {
        let searchString = self.searchField.text
        return searchString!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }

}
