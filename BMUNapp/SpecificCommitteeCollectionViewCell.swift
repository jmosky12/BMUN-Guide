//
//  SpecificCommitteeCollectionViewCell.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

class SpecificCommitteeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var committeeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
    }

}
