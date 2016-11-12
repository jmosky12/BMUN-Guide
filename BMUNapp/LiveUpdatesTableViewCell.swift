//
//  LiveUpdatesTableViewCell.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/31/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class LiveUpdatesTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tweetText.layer.cornerRadius = 7.0
        self.tweetText.clipsToBounds = true
        self.avatar.layer.cornerRadius = 3.0
        self.avatar.clipsToBounds = true
        
        // Ensures table cell separators are set up correctly
        self.separatorInset = UIEdgeInsets.zero
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsets.zero
        
        self.selectionStyle = .none
    }

    
}
