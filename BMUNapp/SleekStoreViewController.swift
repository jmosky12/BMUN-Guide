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
		
        let textColor = UIColor.white
        let textFont = UIFont(name: "Avenir", size: 35.0)
        let titleTextAttributes: [NSAttributedStringKey:Any] = [
			NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): textFont!,
			NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): textColor,
            ]
        self.navigationController!.navigationBar.titleTextAttributes = titleTextAttributes
		
		self.navigationController?.navigationBar.tintColor = UIColor.white
		self.navigationController?.navigationBar.barTintColor = UIColor.black
		
		let habitat = ProductViewController(image: #imageLiteral(resourceName: "givedirectly"), itemTitle: "Conference Cause", price: "Any donations accepted!")
		let newShirt = ProductViewController(image: #imageLiteral(resourceName: "old_shirts"), itemTitle: "BMUN LXVI Shirt", price: "$10")
		let oldShirt = ProductViewController(image: #imageLiteral(resourceName: "old_shirts"), itemTitle: "Past BMUN Shirts", price: "$3")
		self.constrainInView(content: habitat, parentView: self.item1)
		self.constrainInView(content: newShirt, parentView: self.item2)
		self.constrainInView(content: oldShirt, parentView: self.item3)
    }
	
	func constrainInView(content: UIViewController, parentView: UIView) {
		self.addChildViewController(content)
		parentView.addSubview(content.view)
		content.didMove(toParentViewController: self)
		let horzConstraints: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "H:|[content]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["content": content.view])
		let vertConstraints: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:|[content]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["content": content.view])
		self.view!.addConstraints(horzConstraints)
		self.view!.addConstraints(vertConstraints)
		content.view.translatesAutoresizingMaskIntoConstraints = false
	}

}
