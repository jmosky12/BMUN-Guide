//
//  SleekStoreViewController.swift
//  BMUNapp
//
//  Created by Michael Eliot on 2/18/17.
//  Copyright © 2017 Jake Moskowitz. All rights reserved.
//

import UIKit

class SleekStoreViewController: UIViewController {
	
	@IBOutlet var item1: UIView!
	@IBOutlet var item2: UIView!
	@IBOutlet var item3: UIView!
	
	
	init() {
		super.init(nibName: "SleekStoreViewController", bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
        self.navigationController!.navigationBar.titleTextAttributes = Utils.getTitleTextAttributes(fontName: "Avenir", fontSize: 35.0, textColor: UIColor.white)
		
		self.navigationController?.navigationBar.tintColor = UIColor.white
		self.navigationController?.navigationBar.barTintColor = UIColor.black
		
		// adds product views into the item views
		let habitat = ProductViewController(image: #imageLiteral(resourceName: "givedirectly"), itemTitle: "Conference Cause", price: "Any donations accepted!")
		let newShirt = ProductViewController(image: #imageLiteral(resourceName: "old_shirts"), itemTitle: "BMUN LXVI Shirt", price: "$10")
		let oldShirt = ProductViewController(image: #imageLiteral(resourceName: "old_shirts"), itemTitle: "Past BMUN Shirts", price: "$3")
		Utils.constrainInView(vc: self, content: habitat, parentView: self.item1)
		Utils.constrainInView(vc: self, content: newShirt, parentView: self.item2)
		Utils.constrainInView(vc: self, content: oldShirt, parentView: self.item3)
    }

}
