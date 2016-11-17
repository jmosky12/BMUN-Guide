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
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    @IBOutlet weak var deleteItemButton: UIButton!
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
        let productName = object["title"] as? String
        switch productName! {
        case "Conference Cause":
            self.quantityLabel.text = String(describing: Storage.quantityConferenceCause)
        case "KeyChain":
            self.quantityLabel.text = String(describing: Storage.quantityKeychain)
        case "hat":
            self.quantityLabel.text = String(describing: Storage.quantityHat)
        default:
            self.quantityLabel.text = String(describing: Storage.quantityTShirt)
        }
        if (Int(quantityLabel.text!)! > 0) {
            deleteItemButton.isHidden = false
            addToCartButton.isHidden = true
        } else {
            deleteItemButton.isHidden = true
            addToCartButton.isHidden = false
        }
        
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

    //actually fully removes item from cart
    @IBAction func subtractOneItem(_ sender: AnyObject) {
        let productName = object["title"] as? String
        switch productName! {
        case "Conference Cause":
            Storage.quantityConferenceCause = 0
            self.quantityLabel.text = String(describing: 0)
        case "KeyChain":
            Storage.quantityKeychain = 0
            self.quantityLabel.text = String(describing: 0)
        case "Hat":
            Storage.quantityHat = 0
            self.quantityLabel.text = String(describing: 0)
        default:
            Storage.quantityTShirt = 0
            self.quantityLabel.text = String(describing: 0)
        }
    }

    //adds one item to cart
    @IBAction func addOneItem(_ sender: AnyObject) {
        let productName = object["title"] as? String
        switch productName! {
        case "Conference Cause":
            Storage.quantityConferenceCause += 1
            self.quantityLabel.text = String(describing: Storage.quantityConferenceCause)
        case "KeyChain":
            Storage.quantityKeychain += 1
            self.quantityLabel.text = String(describing: Storage.quantityKeychain)
        case "Hat":
            Storage.quantityHat += 1
            self.quantityLabel.text = String(describing: Storage.quantityHat)
        default:
            Storage.quantityTShirt += 1
            self.quantityLabel.text = String(describing: Storage.quantityTShirt)
        }
            }
    @IBAction func addToCart(_ sender: AnyObject) {
        // add product to cart
        let productid = self.object?["id"] as? String
        Moltin.sharedInstance().cart.insertItem(withId: productid, quantity: Int(quantityLabel.text!)!, andModifiersOrNil: nil, success: {(response) -> Void in
            //Display message to user
            let alert = UIAlertController(title: "Added to cart!", message: "Added Item to cart!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            }, failure: {(response, error) -> Void in
                //couldn't add product to cart
                print("couldn't add item")
        })
        addToCartButton.isHidden = true
        deleteItemButton.isHidden = false
        

    }
    
    @IBAction func deleteFromCart(_ sender: AnyObject) {
    // remove product from cart
        let productid = self.object?["id"] as? String
        Moltin.sharedInstance().cart.removeItem(withId: productid, success: {(response) -> Void in
            //Display message to user
            let alert = UIAlertController(title: "Removed from Cart!", message: "Removed Item from cart!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
    
            }, failure: {(response, error) -> Void in
                //couldn't add product to cart
                print("couldn't add item")
        })
        deleteItemButton.isHidden = true
        addToCartButton.isHidden = false
    }
    

}
