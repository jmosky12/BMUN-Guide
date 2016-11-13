//
//  CartTableViewController.swift
//  BMUNapp
//
//  Created by Michael Eliot on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit
import Moltin

class CartTableViewController: UITableViewController {
    
    var nameList = [String]()
    var priceList = [String]()
    
    init() {
        super.init(nibName: "CartTableViewController", bundle: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 24.0/255.0, green: 70.0/255.0, blue: 148.0/255.0, alpha: 1.0)
        edgesForExtendedLayout = UIRectEdge()
        let nib: UINib = UINib(nibName: "CartTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cartCell")
        
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

        
        Moltin.sharedInstance().cart.getContentsWithsuccess({ (response) -> Void in
            let cartData = (response! as! [String: AnyObject])
            print("Got cart data: \(cartData)")
            
            // Extract the products out of the cart...
            var cartItems = cartData["result"]?["contents"] as! NSDictionary
            
            for item in cartItems {
                let innerShit = item.value as? NSDictionary
                let name = innerShit?["name"] as? String
                self.nameList.append(name!)
                let isItPricing = innerShit?["pricing"] as? NSDictionary
                let isItRaw = isItPricing?["raw"] as? NSDictionary
                let isitTax = isItRaw?["without_tax"] as? NSNumber
                print(isItPricing)
                print(isItRaw)
                print(isitTax)
//                self.priceList.append(cartPrice!)
            }
            
            
            
            // Get cart total price
            let cartPrice = ((((cartData["result"] as? NSDictionary)?["totals"] as? NSDictionary)?["post_discount"] as? NSDictionary)?["formatted"] as? NSDictionary)?["without_tax"] as? String
            self.priceList.append(cartPrice!)
            self.nameList.append("Total")
            print("Total cart price: \(cartPrice)")
            
            }, failure: { (response, error) -> Void in
                print("Something went wrong...")
                print(error)
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? CartTableViewCell
        cell?.priceLabel.text = priceList[indexPath.row]
        cell?.itemLabel.text = nameList[indexPath.row]
        return cell!
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
