//
//  TimelineTableViewCell.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 2/4/17.
//  Copyright © 2017 Jake Moskowitz. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {

	@IBOutlet weak var eventTitle: UILabel!
	@IBOutlet weak var eventTime: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
		self.eventTitle.backgroundColor = Storage.lightBlue
		self.eventTitle.clipsToBounds = true
		self.eventTitle.layer.cornerRadius = 7
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
