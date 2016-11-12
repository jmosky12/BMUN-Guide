//
//  DelegateTableViewCell.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/11/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class DelegateTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    var type: DelegateGuideTableViewController.DelegateCellType!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Ensures table cell separators are set up correctly
        self.separatorInset = UIEdgeInsets.zero
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsets.zero
        
        self.backgroundImage.clipsToBounds = true
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }

    // Sets the properties of the cell depending on the enum specified in the cellForRowAtIndexPath method in DelegateTableViewController.swift
    func bindData(_ type: DelegateGuideTableViewController.DelegateCellType) {
        self.type = type
        self.backgroundImage.image = type.backgroundImage()
        self.cellLabel.text = type.rawValue
    }
    
}
