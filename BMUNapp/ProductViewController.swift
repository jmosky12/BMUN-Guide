//
//  ProductViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 2/19/17.
//  Copyright © 2017 Jake Moskowitz. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
	
	@IBOutlet var productImageView: UIImageView!
	@IBOutlet var productLabel: UILabel!
	var image: UIImage
	var itemTitle: String
	var price: String
	
	init(image: UIImage, itemTitle: String, price: String) {
		self.image = image
		self.itemTitle = itemTitle
		self.price = price
		super.init(nibName: "ProductViewController", bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.productImageView.layer.cornerRadius = 7
		self.productImageView.image = self.image
		self.productLabel.text = "\(self.itemTitle)\n\n\(self.price)"
    }


}
