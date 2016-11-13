//
//  TimelineCollectionViewCell.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

class TimelineCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        self.alpha = 0.85
    }

}
