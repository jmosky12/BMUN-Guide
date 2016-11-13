//
//  StoreDetailViewController.swift
//  BMUNapp
//
//  Created by Michael Eliot on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit
import Moltin

class StoreDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var object: AnyObject!
    
    init(object: AnyObject) {
        self.object = object
        super.init(nibName: "StoreDetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        if let detail = self.object {
            //Set Title Label
            if let title = detail["title"] as? String {
                self.titleLabel?.text = title
            }
            
            //Set Description Label
            if let description = detail["description"] as? String {
                self.descriptionLabel?.text = description
            }
            
            //Set Price Label
            if let price = detail.value(forKeyPath: "price.data.formatted.without_tax") as? String {
                self.priceLabel?.text = price
            }

        }
    }
    
    @IBAction func AddToCartTapped(_ sender: AnyObject) {
        // get the product id
        let productid = self.object?["id"] as? String
        
        // add product to cart
        Moltin.sharedInstance().cart.insertItem(withId: productid, quantity: 1, andModifiersOrNil: nil, success: {(response) -> Void in
            //Display message to user
            let alert = UIAlertController(title: "Added to cart!", message: "Added item to cart!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            }, failure: {(response, error) -> Void in
                //couldn't add product to cart
                print("couldn't add item")
        })
    }
    /*
    // MARK: - Navigation

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
