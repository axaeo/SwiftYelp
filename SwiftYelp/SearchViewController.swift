//
//  SearchViewController.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-10.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var businessSearchResults: Array<Business>?
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false);
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "search" {
            let searchResultVC:SearchResultViewController = segue.destinationViewController as! SearchResultViewController
            searchResultVC.businessSearchResults = self.businessSearchResults;
        }
    }
    
    @IBAction func submitSearch(sender: UIButton) {
        AppDelegate.instance()
            .yelpCommunicator!.searchWithTerm("Ethiopian",
                                                location: "Toronto",
                                                callback: {(data, error) in
                                                    if (data != nil) {
                                                        self.businessSearchResults = data
                                                        dispatch_async(dispatch_get_main_queue(),{
                                                            self.showResultsPage()
                                                        })
                                                    } else {
                                                        //TODO show error message
                                                    }
                                                })
        
    }
    
    func showResultsPage() {
        self.performSegueWithIdentifier("search", sender: self)
    }

}
