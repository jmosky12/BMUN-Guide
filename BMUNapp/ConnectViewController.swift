//
//  ConnectViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 2/6/18.
//  Copyright © 2018 Jake Moskowitz. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController {

	@IBOutlet var questionsIV: UIImageView!
	@IBOutlet var socialMediaIV: UIImageView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		socialMediaIV.image = UIImage(named: "socialmedia")
		questionsIV.image = UIImage(named: "questions")
		
		socialMediaIV.clipsToBounds = true
		questionsIV.clipsToBounds = true
		
		socialMediaIV.layer.cornerRadius = 50
		questionsIV.layer.cornerRadius = 50
		
		let socialMediaGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ConnectViewController.socialMediaSelected))
		let questionsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ConnectViewController.questionsSelected))
		
		socialMediaIV.addGestureRecognizer(socialMediaGestureRecognizer)
		questionsIV.addGestureRecognizer(questionsGestureRecognizer)
		
		self.navigationController!.navigationBar.titleTextAttributes = Utils.getTitleTextAttributes(fontName: "Avenir", fontSize: 35.0, textColor: UIColor.white)
    }

	// pushes up social media page
	@objc func socialMediaSelected() {
		let vc = SocialMediaViewController()
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	// pushes up questions/email page
	@objc func questionsSelected() {
		let vc = QuestionsViewController()
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
}
