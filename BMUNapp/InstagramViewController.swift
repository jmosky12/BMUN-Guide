//
//  InstagramViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 2/19/17.
//  Copyright © 2017 Jake Moskowitz. All rights reserved.
//

import UIKit

class InstagramViewController: UIViewController {

	@IBOutlet var webView: UIWebView!
	
	init() {
		super.init(nibName: "InstagramViewController", bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.webView.scalesPageToFit = true
		
		let textColor = UIColor.white
		let textFont = UIFont(name: "Avenir", size: 35.0)
		let titleTextAttributes: [NSAttributedStringKey:Any] = [
			NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): textFont!,
			NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): textColor,
			]
		self.navigationController!.navigationBar.titleTextAttributes = titleTextAttributes
		self.navigationController?.navigationBar.tintColor = UIColor.white
		
		let authURL = URL(string: "https://www.instagram.com/berkeleymun/")
		self.webView.loadRequest(URLRequest(url: authURL!))
    }

}
