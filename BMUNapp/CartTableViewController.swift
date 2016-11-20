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
    
    var itemArray = [[String]]()
    var total = "0.00"
    
    init() {
        super.init(nibName: "CartTableViewController", bundle: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Place Order >", style: .plain, target: self,action: #selector(placeOrder))
        
        view.backgroundColor = UIColor.black
        edgesForExtendedLayout = UIRectEdge()
        let nib: UINib = UINib(nibName: "CartTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "CartTableViewCell")
        
        // Ensures table cell separators are set up correctly
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.preservesSuperviewLayoutMargins = false
        tableView.layoutMargins = UIEdgeInsets.zero
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        
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
            
            // Extract the products out of the cart...
            if let cartItems = cartData["result"]?["contents"] as? NSDictionary {
                var firstArray = [String]()
                firstArray.append("Name")
                firstArray.append("Price Per Unit"); firstArray.append("Quantity")
                firstArray.append("Price")
                self.itemArray.append(firstArray)
                
                for item in cartItems {
                    var indivArray = [String]()
                    let innerShit = item.value as? NSDictionary
                    let name = innerShit?["name"] as? String
                    let pricing = innerShit?["pricing"] as? NSDictionary
                    let quantity = innerShit?["quantity"] as! Float
                    let raw = pricing?["raw"] as? NSDictionary
                    let price = raw?["without_tax"] as! Float
                    indivArray.append(name!)
                    indivArray.append(String(describing: price))
                    indivArray.append(String(describing: quantity))
                    indivArray.append(String(describing: price * quantity))
                    self.itemArray.append(indivArray)
                }
                
                // Get cart total price
                let cartPrice = ((((cartData["result"] as? NSDictionary)?["totals"] as? NSDictionary)?["post_discount"] as? NSDictionary)?["formatted"] as? NSDictionary)?["without_tax"] as? String
                self.total = cartPrice!
                var lastArray = [String]()
                lastArray.append("Total")
                lastArray.append(""); lastArray.append("")
                lastArray.append(cartPrice!)
                self.itemArray.append(lastArray)
            } else {
                var emptyCartArray = [String]()
                emptyCartArray.append("No Items in Cart")
                emptyCartArray.append(""); emptyCartArray.append("")
                emptyCartArray.append("")
                self.itemArray.append(emptyCartArray)
            }
            self.tableView?.reloadData()
                }, failure: { (response, error) -> Void in
                print("Something went wrong...")
                print(error)
            })
        }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell
        var curArray = itemArray[indexPath.row]
        cell!.itemLabel.text = curArray[0]
        cell!.ppuLabel.text = curArray[1]
        cell!.quantityLabel.text = curArray[2]
        if (indexPath.row == 0 || indexPath.row == itemArray.count - 1) {
            cell!.priceLabel.text = curArray[3]
        } else {
            cell!.priceLabel.text = "$" + curArray[3]
        }
        
        return cell!
    }
    
    func placeOrder() {
        let vc = CheckoutViewController(total: self.total)
        self.navigationController?.pushViewController(vc, animated: true)
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
