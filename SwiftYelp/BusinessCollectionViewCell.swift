//
//  BusinessCollectionViewCell.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-11.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit

class BusinessCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2;
        self.layer.borderColor = UIColor(colorLiteralRed: 182/255, green: 56/255, blue: 34/255, alpha: 1).CGColor
        self.layer.masksToBounds = true
    }
}
