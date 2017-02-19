//
//  InstaTableViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit
import SDWebImage

class InstaTableViewController: UITableViewController {
	
	var imageHeights: [CGFloat] = []
	var noDataLabel: UILabel!
    
    init() {
        super.init(nibName: "InstaTableViewController", bundle: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 100))
		self.noDataLabel.center = self.tableView.center
		self.noDataLabel.textAlignment = .center
		self.noDataLabel.text = "Network Connection Error"
		self.view.bringSubview(toFront: self.noDataLabel)
		self.noDataLabel.isHidden = true
		self.view.addSubview(self.noDataLabel)

        let nib1: UINib = UINib(nibName: "InstaPicTableViewCell", bundle: nil)
        self.tableView.register(nib1, forCellReuseIdentifier: "instaPic")
        let nib2: UINib = UINib(nibName: "InstaDescTableViewCell", bundle: nil)
        self.tableView.register(nib2, forCellReuseIdentifier: "instaDesc")
        
        self.tableView.separatorColor = UIColor.clear
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
		//self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
		
		self.tableView.estimatedRowHeight = 375
		self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.black
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		let count = 2*Storage.instaList.count
		if count == 0 {
			self.noDataLabel.isHidden = false
		}
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "instaPic", for: indexPath) as! InstaPicTableViewCell
            cell.tag = indexPath.row/2
            cell.instaImageView.image = nil
            DispatchQueue.global().async {
                () -> Void in
                    // Background thread
				let urlPic = Storage.instaList[indexPath.row/2].urlString
				let url = URL(string: urlPic)
				cell.instaImageView.sd_setImage(with: url)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "instaDesc", for: indexPath) as! InstaDescTableViewCell
            let description = Storage.instaList[indexPath.row/2].description
            cell.titleLabel.text = description
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            return cell
        }
    }
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row % 2 == 0 {
			return Storage.instaHeights[indexPath.row/2]
		}
		return UITableViewAutomaticDimension
	}
    
}
