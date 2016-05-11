//
//  BusinessCollectionHeaderView.swift
//  SwiftYelp
//
//  Created by Alexander Orchard on 2016-05-11.
//  Copyright © 2016 Intelliware Development. All rights reserved.
//

import UIKit

protocol BusinessCollectionHeaderViewDelegate: class {
    func didTapHeader(sender: BusinessCollectionHeaderView)
}

class BusinessCollectionHeaderView: UICollectionReusableView {
    var delegate:BusinessCollectionHeaderViewDelegate?
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        let border = CALayer()
        let width = CGFloat(1)
        border.borderColor = UIColor(colorLiteralRed: 182/255, green: 56/255, blue: 34/255, alpha: 1).CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func onTap() {
        delegate!.didTapHeader(self)
        
    }
}
