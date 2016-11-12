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
        switch(section) {
        case 0:
            return 7
        case 1:
            return 6
        case 2:
            return 3
        default:
            return 1
        }
    }

    // Sets corresponding info for each cell that represents a specific event of that day
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as! TimelineTableViewCell
        let event = cell.eventTitle
        let time = cell.eventTime
        switch((indexPath as NSIndexPath).section) {
        case 0:
            switch((indexPath as NSIndexPath).row) {
            case 0:
                event?.text = "Registration (Kerr Lobby)"
                time?.text = " 12:00pm-4:00pm"
            case 1:
                event?.text = "International Students Reception (315 Wheeler)"
                time?.text = " 2:30pm-4:30pm"
            case 2:
                event?.text = "Procedure Workshops (2060 VLSB)"
                time?.text = " 3:00pm-4:00pm"
            case 3:
                event?.text = "Line Up For Opening Ceremonies (Sproul Plaza)"
                time?.text = " 4:00pm-5:00pm"
            case 4:
                event?.text = "Opening Ceremonies (Paulley Ballroom)"
                time?.text = " 5:30pm-6:30pm"
            case 5:
                event?.text = "Committee Meet Up (Lower Sproul)"
                time?.text = " 6:30pm-7:00pm"
            case 6:
                event?.text = "First Committee Session"
                time?.text = " 7:00pm-9:45pm"
            default:
                event?.text = "Uh Oh"
                time?.text = "Default"
            }
        case 1:
            switch((indexPath as NSIndexPath).row) {
            case 0:
                event?.text = "Second Committee Session"
                time?.text = " 9:00am-12:45pm"
            case 1:
                event?.text = "Advisors Meeting (Stephens Lounge)"
                time?.text = " 10:00am-11:30am"
            case 2:
                event?.text = "Lunch Break"
                time?.text = " 12:45pm-1:45pm"
            case 3:
                event?.text = "Third Committee Session"
                time?.text = " 1:45pm-4:45pm"
            case 4:
                event?.text = "Head Delegate Meeting (170 Barrows)"
                time?.text = " 5:00pm-6:00pm"
            case 5:
                event?.text = "Delegate Dance (Paulley Ballroom)"
                time?.text = " 7:30pm-10:30pm"
            default:
                event?.text = "Uh Oh"
                time?.text = "Default"
            }
        case 2:
            switch((indexPath as NSIndexPath).row) {
            case 0:
                event?.text = "Fourth Committee Session"
                time?.text = " 9:30am-12:30pm"
            case 1:
                event?.text = "Lunch Break"
                time?.text = " 12:30pm-2:00pm"
            case 2:
                event?.text = "Closing Ceremonies (Paulley Ballroom)"
                time?.text = " 2:00pm-3:30pm"
            default:
                event?.text = "Uh Oh"
                time?.text = "Default"
            }
        default:
            event?.text = "Uh Oh"
            time?.text = "Default"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title: String!
        switch(section) {
        case 0:
            title = "Friday, March 4"
        case 1:
            title = "Saturday, March 5"
        case 2:
            title = "Sunday, March 6"
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
            titleLabel.text = "Friday, March 4"
        case 1:
            titleLabel.text = "Saturday, March 5"
        case 2:
            titleLabel.text = "Sunday, March 6"
        default:
            titleLabel.text = "No"
        }
        headerView.addSubview(titleLabel)
        return headerView
    }

}
