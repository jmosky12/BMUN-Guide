//
//  ChecklistTableViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/9/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

protocol ChecklistTableViewControllerDelegate {
    func replaceCellData(data: NSMutableArray)
    func getCellData() -> NSMutableArray
}

class ChecklistTableViewController: UITableViewController, ChecklistTableViewControllerDelegate {
    
    var cellData: NSMutableArray = []
    var addButton: UIBarButtonItem!
    let darkBlue = UIColor(red: 24.0/255.0, green: 73.0/255.0, blue: 140.0/255.0, alpha: 1.0)
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 140
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.preservesSuperviewLayoutMargins = false
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.backgroundColor = darkBlue
        
        self.tableView.allowsMultipleSelectionDuringEditing = false
        addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "didPressAddButton")
        self.navigationItem.rightBarButtonItem = addButton
        
        let nib: UINib = UINib(nibName: "ChecklistTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "ChecklistTableViewCell")
        
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistTableViewCell") as! ChecklistTableViewCell
        let cellTitle = cell.cellTitle
        let cellDetail = cell.cellDetail
        cellTitle.text = " \(cellData[indexPath.row][0])"
        cellDetail.text = "\(cellData[indexPath.row][1])"
        
        cell.selectionStyle = .None
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            cellData.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140.0
    }
    
    override func viewWillDisappear(animated: Bool) {
        
    }



    // MARK: - Navigation
    
    func didPressAddButton() {
        let vc = CreateTaskViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - NSCoding
    
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(cellData, forKey: "cellData")
    }
    
    /*required convenience init?(coder aDecoder: NSCoder) {
        cellData = aDecoder.decodeObjectForKey("cellData") as! NSMutableArray
        self.init()
    }*/
    
    
    //MARK: - Delegate

    
    func getCellData() -> NSMutableArray {
        return cellData
    }
    
    func replaceCellData(data: NSMutableArray) {
        cellData = data
        tableView.reloadData()
    }

}
