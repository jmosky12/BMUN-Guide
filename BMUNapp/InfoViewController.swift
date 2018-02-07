//
//  InfoViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/22/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var timelineIV: UIImageView!
    @IBOutlet weak var storeIV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeIV.image = UIImage(named: "logo1024")
        timelineIV.image = UIImage(named: "timeline")
        
        storeIV.clipsToBounds = true
        timelineIV.clipsToBounds = true
        
        storeIV.layer.cornerRadius = 50
        timelineIV.layer.cornerRadius = 50
        
        let storeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InfoViewController.storeSelected))
        let timelineGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InfoViewController.timelineSelected))
        
        storeIV.addGestureRecognizer(storeGestureRecognizer)
        timelineIV.addGestureRecognizer(timelineGestureRecognizer)
        
		let textColor = UIColor.white
		let textFont = UIFont(name: "Avenir", size: 35.0)
		let titleTextAttributes: [NSAttributedStringKey:Any] = [
			NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): textFont!,
			NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): textColor,
			]
		self.navigationController!.navigationBar.titleTextAttributes = titleTextAttributes
    }

    @objc func storeSelected() {
        let vc = SleekStoreViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func timelineSelected() {
        let vc = TimelineCollectionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
