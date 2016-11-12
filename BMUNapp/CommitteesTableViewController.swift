//
//  CommitteesTableViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/10/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class CommitteesTableViewController: UITableViewController {
    
    var section: Int?
    
    init(section: Int) {
        self.section = section
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
        
        self.tableView.estimatedRowHeight = 127
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
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
        return 1
    }

    // Specifies the number of committee cells needed under each section specified above
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num: Int!
        switch(self.section!) {
        case 0:
            num = Storage.blocACommittees?.count
        case 1:
            num = Storage.blocBCommittees?.count
        case 2:
            num = Storage.specializedCommittees?.count
        case 3:
            num = Storage.crisisCommittees?.count
        default:
            num = 0
        }
        return num
    }

    // Sets each cell up with its committee title
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "committeeCell", for: indexPath) as! CommitteeTableViewCell
        let label = cell.viewWithTag(1) as? UILabel
        var committee: [String: Any]?
        var text: String?
        
        switch(self.section!) {
        case 0:
            committee = Storage.blocACommittees?[String(indexPath.row)] as! [String : Any]?
            text = committee?["name"] as? String
        case 1:
            committee = Storage.blocBCommittees?[String(indexPath.row)] as! [String : Any]?
            text = committee?["name"] as? String
        case 2:
            committee = Storage.specializedCommittees?[String(indexPath.row)] as! [String : Any]?
            text = committee?["name"] as? String
        case 3:
            committee = Storage.crisisCommittees?[String(indexPath.row)] as! [String : Any]?
            text = committee?["name"] as? String
        default:
            text = "label"
        }
        label?.text = text
        /*let sectionRef = FIRDatabase.database().reference().child("Committee").child(String(indexPath.section))
        let committeeRef = sectionRef.child(String(indexPath.row))
        let currentRef = committeeRef.child("name")
        currentRef.observeSingleEvent(of: .value, with: { (snapshot) in
            label?.text = snapshot.value as? String
        })*/
        return cell
    }
    
    // Detects when a cell has been selected, and opens a CommitteeDetailViewController with the section and row info that tells it which committee to load
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommitteeDetailViewController(section: self.section!, row: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Designs the section header
    /*override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    }*/
}
