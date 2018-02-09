//
//  SocialMediaViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/22/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

class SocialMediaViewController: UIViewController {
    
    @IBOutlet weak var twitterIV: UIImageView!
    @IBOutlet weak var instaIV: UIImageView!
    
    init() {
        super.init(nibName: "SocialMediaViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        twitterIV.image = UIImage(named: "twitterLogo")
        instaIV.image = UIImage(named: "instaLogo")
        
        twitterIV.clipsToBounds = true
        instaIV.clipsToBounds = true
        
        twitterIV.layer.cornerRadius = 50
        instaIV.layer.cornerRadius = 50
        
        let twitterGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SocialMediaViewController.twitterSelected))
        let instaGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SocialMediaViewController.instaSelected))
        
        twitterIV.addGestureRecognizer(twitterGestureRecognizer)
        instaIV.addGestureRecognizer(instaGestureRecognizer)
        
        let textColor = UIColor.white
        let textFont = UIFont(name: "Avenir", size: 35.0)
        let titleTextAttributes: [NSAttributedStringKey:Any] = [
			NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): textFont!,
			NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): textColor,
            ]
        self.navigationController!.navigationBar.titleTextAttributes = titleTextAttributes
		
		self.navigationController?.navigationBar.tintColor = UIColor.white
		self.navigationController?.navigationBar.barTintColor = UIColor.black

    }

    @objc func twitterSelected() {
        let vc = LiveUpdatesTableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func instaSelected() {
        let vc = InstagramViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    


}
