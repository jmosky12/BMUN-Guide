//
//  TimelineEventTableViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 2/4/17.
//  Copyright © 2017 Jake Moskowitz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "timelineTableCell"

class TimelineEventTableViewController: UITableViewController {
	
	var section: Int?
	
	init(section: Int) {
		self.section = section
		super.init(nibName: "TimelineEventTableViewController", bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
        
    override func viewDidLoad() {
        super.viewDidLoad()
		
		edgesForExtendedLayout = UIRectEdge()
		
		let nib: UINib = UINib(nibName: "TimelineTableViewCell", bundle: nil)
		self.tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
		
		// Ensures table cells are set up correctly
		Utils.setupTableView(tableView: self.tableView, rowHeight: 100)
		self.tableView.separatorColor = Storage.lightGray
		self.tableView.alwaysBounceVertical = true

		self.navigationController!.navigationBar.titleTextAttributes = Utils.getTitleTextAttributes(fontName: "Avenir", fontSize: 35.0, textColor: UIColor.white)
		
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		/*if Storage.noData {
			let alert = UIAlertController(title: "Network Connection Error", message: "Please resolve any connection errors before using the app.", preferredStyle: .alert)
			let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
			})
			alert.addAction(action)
			present(alert, animated: true, completion: {
			})
			return 0
		}*/
		let num: Int!
		switch(self.section!) {
		case 0:
			num = Storage.dayOneTimeline.count - 1
		case 1:
			num = Storage.dayTwoTimeline.count - 1
		case 2:
			num = Storage.dayThreeTimeline.count - 1
		default:
			num = 0
		}
		return num
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TimelineTableViewCell
		let event = cell.eventTitle as UILabel
		let time = cell.eventTime as UILabel
		var timeline: [String: Any]?
		
		switch(self.section!) {
		case 0:
			timeline = Storage.dayOneTimeline[String(indexPath.row)] as? [String: Any]
			event.text = timeline?["title"] as? String
			time.text = timeline?["time"] as? String
		case 1:
			timeline = Storage.dayTwoTimeline[String(indexPath.row)] as? [String: Any]
			event.text = timeline?["title"] as? String
			time.text = timeline?["time"] as? String
		case 2:
			timeline = Storage.dayThreeTimeline[String(indexPath.row)] as? [String: Any]
			event.text = timeline?["title"] as? String
			time.text = timeline?["time"] as? String
		default:
			event.text = "nil"
			time.text = "nil"
		}
		return cell
    }
	
	

}
