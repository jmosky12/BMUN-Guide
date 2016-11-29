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
    @IBOutlet weak var plusOneButton: UIButton!
    @IBOutlet weak var minusOneButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    
    var object: AnyObject!
    let defaults = UserDefaults.standard
    var inCart: Bool!
    
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
        self.quantityLabel.text = String(defaults.integer(forKey: productName!))
        self.inCart =  defaults.bool(forKey: productName! + "InCart")
        
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
        
        if self.inCart == true {
            print("in cart")
            self.addToCartButton.setTitle("Remove Item from Cart", for: .normal)
        } else {
            print("not in cart")
            self.addToCartButton.setTitle("Add Item to Cart", for: .normal)
        }
        
        self.addToCartButton.layer.borderWidth = 1
        self.addToCartButton.layer.cornerRadius = 5
        self.addToCartButton.layer.borderColor = UIColor.white.cgColor
        self.productImageView.clipsToBounds = true
        self.productImageView.layer.cornerRadius = 5
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    //actually fully removes item from cart
    @IBAction func subtractOneItem(_ sender: AnyObject) {
        let productName = object["title"] as? String
        if (defaults.integer(forKey: productName!) > 0) {
            defaults.set(defaults.integer(forKey: productName!) - 1, forKey: productName!)
            self.quantityLabel.text = String(defaults.integer(forKey: productName!))
        }
        sync()
    }

    //adds one item to cart
    @IBAction func addOneItem(_ sender: AnyObject) {
        let productName = object["title"] as? String
        defaults.set(defaults.integer(forKey: productName!) + 1, forKey: productName!)
        self.quantityLabel.text = String(defaults.integer(forKey: productName!))
        sync()
    }
    
    @IBAction func addToCart(_ sender: AnyObject) {
        // add product to cart
        let productName = object["title"] as? String
        let productid = self.object?["id"] as? String
        if self.inCart == true {
            print("do add")
            Moltin.sharedInstance().cart.removeItem(withId: productid, success: {(response) -> Void in
                //Display message to user
                let alert = UIAlertController(title: "Removed from Cart!", message: "Removed Item from cart!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }, failure: {(response, error) -> Void in
                //couldn't add product to cart
                print("couldn't add item")
            })
            defaults.set(false, forKey: productName! + "InCart")
            minusOneButton.isHidden = false
            plusOneButton.isHidden = false
            self.addToCartButton.setTitle("Add Item to Cart", for: .normal)
        } else {
            print("do not add")
            if (Int(quantityLabel.text!)! > 0) {
                Moltin.sharedInstance().cart.insertItem(withId: productid, quantity: Int(quantityLabel.text!)!, andModifiersOrNil: nil, success: {(response) -> Void in
                    //Display message to user
                    let alert = UIAlertController(title: "Added to cart!", message: "Added Item to cart!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }, failure: {(response, error) -> Void in
                    //couldn't add product to cart
                    print("couldn't add item")
                })
                defaults.set(true, forKey: productName! + "InCart")
                minusOneButton.isHidden = true
                plusOneButton.isHidden = true
                self.addToCartButton.setTitle("Remove Item from Cart", for: .normal)
            }
        }
        
    }

}
