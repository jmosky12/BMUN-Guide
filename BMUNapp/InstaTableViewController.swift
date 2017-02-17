//
//  InstaTableViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

class InstaTableViewController: UITableViewController {
	
	var imageHeights: [CGFloat] = []
    
    init() {
        super.init(nibName: "InstaTableViewController", bundle: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 2*Storage.instaList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "instaPic", for: indexPath) as! InstaPicTableViewCell
            cell.tag = indexPath.row/2
            cell.instaImageView.image = nil
            DispatchQueue.global().async {
                () -> Void in
                do {
                    // Background thread
                    let urlPic = Storage.instaList[indexPath.row/2].urlString
                    let url = URL(string: urlPic)
                    let picData = try Data(contentsOf: url!)
                    DispatchQueue.main.async(execute: {
                        if cell.tag == indexPath.row/2 {
                        // UI Updates
                            let image = UIImage(data: picData)
                            cell.instaImageView.image = image
							cell.layoutIfNeeded()
							cell.layoutSubviews()
							
                        }
                        
                    })
                } catch {
                    print("error!")
                }
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
