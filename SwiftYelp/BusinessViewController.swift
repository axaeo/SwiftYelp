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
    
    override func viewWillAppear(animated: Bool) {
        self.title = business?.name
        addressLabel.text = business?.location?.displayAddress![0]
    }

}
