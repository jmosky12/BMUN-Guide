//
//  TimelineTableViewCell.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/12/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Ensures table cell separators are set up correctly
        self.separatorInset = UIEdgeInsets.zero
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsets.zero
        
        self.selectionStyle = .none
    }

    
}
