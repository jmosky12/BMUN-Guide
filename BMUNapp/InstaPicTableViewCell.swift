//
//  InstaPicTableViewCell.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

class InstaPicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var instaImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
		self.selectionStyle = .none
        //self.instaImageView.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
