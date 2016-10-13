//
//  SearchViewController.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-10.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class SearchViewController: UIViewController {

    let searchSegueID:String = "search"
    
    var businessSearchResults: Array<Business>?
    
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        self.searchField.layer.borderWidth = 2;
        self.searchField.layer.cornerRadius = 3;
        self.searchField.layer.masksToBounds = true;
        self.searchField.layer.borderColor = UIColor(colorLiteralRed: 182/255, green: 56/255, blue: 34/255, alpha: 1).cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false);
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == searchSegueID {
            let searchResultVC:BusinessCollectionViewController = segue.destination as! BusinessCollectionViewController
            searchResultVC.businessSearchResults = self.businessSearchResults;
            searchResultVC.searchedTerm = self.searchFieldContents()
        }
    }
    
    func showResultsPage() {
        self.performSegue(withIdentifier: searchSegueID, sender: self)
    }
    
    @IBAction func submitSearch(_ sender: UIButton) {
        
        let searchTerm = self.searchFieldContents()
        
        if searchTerm!.isEmpty {
            return
        }
        
        self.showActivityIndicator { (spinner) in
            AppDelegate.instance()
                .yelpCommunicator!.searchWithTerm(searchTerm!,
                    location: "Toronto",
                    callback: {(data, error) in
                        spinner.removeFromSuperview()
                        if (data != nil) {
                            if (!data!.isEmpty) {
                                self.businessSearchResults = data!.sorted{ $0.name < $1.name }
                                DispatchQueue.main.async(execute: {
                                    
                                    self.showResultsPage()
                                })
                            } else {
                                self.showErrorMessage("There were no results for that search term", title: "No Results")
                            }
                            
                        } else {
                            self.showErrorMessage("Could not retrieve search results", title: "Connnection Error")
                        }
                })
        }
        
        
    }
    
    func searchFieldContents() -> String? {
        let searchString = self.searchField.text
        return searchString!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

}
