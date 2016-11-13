//
//  CheckoutViewController.swift
//  BMUNapp
//
//  Created by Michael Eliot on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit
import Moltin

class CheckoutViewController: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var billingAddress: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var postcode: UITextField!

    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func confirmOrder(_ sender: AnyObject) {
        if self.emptyTextField() {
            print("wow no fucking way")
        } else {
            let orderParameters = [
                "customer": ["first_name": firstName.text!,
                             "last_name":  lastName.text!,
                             "email":      email.text!],
                "shipping": "free_shipping",
                "gateway": "dummy",
                "bill_to": ["first_name": firstName.text!,
                            "last_name":  lastName.text!,
                            "address_1":  billingAddress.text!,
                            "address_2":  "Sunnycreek",
                            "city":       city.text!,
                            "county":     state.text!,
                            "country":    country.text!,
                            "postcode":   postcode.text!,
                            "phone":     phoneNumber.text!],
                "ship_to": "bill_to"
            ] as [String : Any]
            Moltin.sharedInstance().cart.order(withParameters: orderParameters, success: { (response) -> Void in
                // Order succesful
                print("Order succeeded: \(response)")
                
                // Extract the Order ID so that it can be used in payment too...
                let orderID = ((response as! [String: AnyObject])["result"] as! [String: AnyObject])["id"]
                
                
                print("Order ID: \(orderID)")
                }, failure: { (response, error) -> Void in
                    // Order failed
                    print("Order error: \(error)")
            })
        }
    }
    
    func emptyTextField() -> Bool {
        let empty = ""
        if firstName.text == empty
        || lastName.text == empty
        || country.text == empty
        || phoneNumber.text == empty
        || billingAddress.text == empty
        || city.text == empty
        || state.text == empty
        || postcode.text == empty {
            return true
        } else {
            return false
        }
    }


}
