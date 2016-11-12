//
//  TimelineTableViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/10/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 24.0/255.0, green: 70.0/255.0, blue: 148.0/255.0, alpha: 1.0)
        edgesForExtendedLayout = UIRectEdge()
        let nib: UINib = UINib(nibName: "TimelineTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "TimelineTableViewCell")
        
        // Ensures table cell separators are set up correctly
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.preservesSuperviewLayoutMargins = false
        tableView.layoutMargins = UIEdgeInsets.zero
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Sets characteristics for top bar text
        let textColor = UIColor.white
        let textFont = UIFont(name: "Avenir", size: 35.0)
        let titleTextAttributes: [String:NSObject] = [
            NSFontAttributeName: textFont!,
            NSForegroundColorAttributeName: textColor,
        ]
        self.navigationController!.navigationBar.titleTextAttributes = titleTextAttributes
    }
    
    // These two functions below prevent landscape mode
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.portrait]
    }


    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num: Int!
        switch(section) {
        case 0:
            num = Storage.dayOneTimeline?.count
        case 1:
            num = Storage.dayTwoTimeline?.count
        case 2:
            num = Storage.dayThreeTimeline?.count
        default:
            num = 0
        }
        return num
    }

    // Sets corresponding info for each cell that represents a specific event of that day
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as! TimelineTableViewCell
        let event = cell.eventTitle
        let time = cell.eventTime
        var timelineEvent: [String: Any]?
        switch((indexPath as NSIndexPath).section) {
        case 0:
            timelineEvent = Storage.dayOneTimeline?[String(indexPath.row)] as! [String : Any]?
            event?.text = timelineEvent?["title"] as? String
            time?.text = " \(timelineEvent?["time"] as? String)"
        case 1:
            timelineEvent = Storage.dayTwoTimeline?[String(indexPath.row)] as! [String : Any]?
            event?.text = timelineEvent?["title"] as? String
            time?.text = " \(timelineEvent?["time"] as? String)"
        case 2:
            timelineEvent = Storage.dayThreeTimeline?[String(indexPath.row)] as! [String : Any]?
            event?.text = timelineEvent?["title"] as? String
            time?.text = " \(timelineEvent?["time"] as? String)"
        default:
            event?.text = "Default"
            time?.text = "Default"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title: String!
        switch(section) {
        case 0:
            title = Storage.dayOneTimeline?["date"] as! String
        case 1:
            title = Storage.dayTwoTimeline?["date"] as! String
        case 2:
            title = Storage.dayThreeTimeline?["date"] as! String
        default:
            title = "Something's wrong"
        }
        return title
    }
    
    // Designs header of each section that has that day's date
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: 320, height: 30)
        headerView.backgroundColor = UIColor.black
        
        let titleLabel = UILabel(frame: CGRect(x: 5, y: 0, width: 320, height: 30))
        titleLabel.font = UIFont(name: "Thonburi", size: 18)
        titleLabel.textColor = UIColor.white
        switch(section) {
        case 0:
            titleLabel.text = Storage.dayOneTimeline?["date"] as? String
        case 1:
            titleLabel.text = Storage.dayTwoTimeline?["date"] as? String
        case 2:
            titleLabel.text = Storage.dayThreeTimeline?["date"] as? String
        default:
            titleLabel.text = "No"
        }
        headerView.addSubview(titleLabel)
        return headerView
    }

}
