//
//  CartTableViewCell.swift
//  BMUNapp
//
//  Created by Michael Eliot on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.separatorInset = UIEdgeInsets.zero
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsets.zero
        
        self.selectionStyle = .none
    }
    
}
