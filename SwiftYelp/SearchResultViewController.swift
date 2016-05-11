//
//  SearchResultViewController.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-10.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit

class SearchResultViewController: UITableViewController {

    var businessSearchResults: Array<Business>?
    var selectedIndexPath: NSIndexPath?
    
    override func viewDidLoad() {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false);
        self.tableView.reloadData()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.businessSearchResults?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let business = self.businessForIndexPath(indexPath)
        
        cell.textLabel?.text = business.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedIndexPath = indexPath;
        performSegueWithIdentifier("detail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "detail") {
            let destination:BusinessViewController = segue.destinationViewController as! BusinessViewController
            destination.business = self.businessForIndexPath(self.selectedIndexPath!)
        }
    }
    
    func businessForIndexPath(indexPath: NSIndexPath) -> Business {
        return self.businessSearchResults![indexPath.row]
    }
   
    /**
     
     -(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     SearchResultHeader *headerView = [tableView dequeueReusableCellWithIdentifier:SEARCH_HEADER_ID];
     headerView.headerText.text = @"Searched for: \"Ethiopian\"";
     return headerView;
     }

     **/

}
