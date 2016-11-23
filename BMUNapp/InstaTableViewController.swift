//
//  InstaTableViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

class InstaTableViewController: UITableViewController {
    
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
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorColor = UIColor.clear
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        
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
                            cell.instaImageView.contentMode = .scaleAspectFit
                        }
                        
                    })
                } catch {
                    print("error!")
                }
            }
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
