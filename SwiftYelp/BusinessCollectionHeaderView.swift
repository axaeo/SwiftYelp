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
    
    func onTap() {
        delegate!.didTapHeader(self)
        
    }
}
