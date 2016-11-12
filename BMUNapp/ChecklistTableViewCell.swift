//
//  ChecklistTableViewCell.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/11/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class ChecklistTableViewCell: UITableViewCell {
    
    @IBOutlet var cellTitle: UILabel!
    @IBOutlet var cellDetail: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        cellDetail.editable = false
        cellDetail.layer.cornerRadius = 7.0
        cellDetail.clipsToBounds = true
        self.cellDetail.scrollRangeToVisible(NSMakeRange(0, 0))
        cellTitle.layer.cornerRadius = 7.0
        cellTitle.clipsToBounds = true
        
        self.separatorInset = UIEdgeInsetsZero
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsetsZero
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
