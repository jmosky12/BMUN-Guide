//
//  CommitteesTableViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/10/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class CommitteesTableViewController: UITableViewController {
    
    struct MyStruct {
        var name: String = ""
    }
    
    let myArray: [MyStruct] = []
    
    
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
        let nib: UINib = UINib(nibName: "CommitteeTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "committeeCell")
        
        tableView.estimatedRowHeight = 127
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
        return 4
    }
    
    // Gives section titles to the different groupings of committees
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title: String!
        switch(section) {
            case 0:
                title = "Bloc A"
            case 1:
                title = "Bloc B"
            case 2:
                title = "Specialized"
            case 3:
                title = "Crisis"
            default:
                title = "Something's wrong"
        }
        return title
    }

    // Specifies the number of committee cells needed under each section specified above
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num: Int!
        switch(section) {
            case 0:
                num = 3
            case 1:
                num = 5
            case 2:
                num = 8
            case 3:
                num = 3
            default:
                num = 5
        }
        return num
    }

    // Sets each cell up with its committee title
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "committeeCell", for: indexPath) as! CommitteeTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tag = "\((indexPath as NSIndexPath).section)\((indexPath as NSIndexPath).row)"
        let vc = CommitteeDetailViewController(tag: tag)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Designs the section header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: 320, height: 30)
        headerView.backgroundColor = UIColor.black
        
        let titleLabel = UILabel(frame: CGRect(x: 5, y: 0, width: 320, height: 30))
        titleLabel.font = UIFont(name: "Thonburi", size: 18)
        titleLabel.textColor = UIColor.white
        switch(section) {
        case 0:
            titleLabel.text = "Bloc A"
        case 1:
            titleLabel.text = "Bloc B"
        case 2:
            titleLabel.text = "Specialized"
        case 3:
            titleLabel.text = "Crisis"
        default:
            titleLabel.text = "No"
        }
        headerView.addSubview(titleLabel)
        return headerView
    }

}
