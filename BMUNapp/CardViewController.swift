//
//  CardViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 2/6/18.
//  Copyright © 2018 Jake Moskowitz. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
	
	@IBOutlet var frontTextView: UITextView!
	@IBOutlet var backTextView: UITextView!
	@IBOutlet var createButton: UIButton!
	
	var keyboard = true
	var delegate: FlashcardsViewControllerDelegate?
	
	
	init() {
		super.init(nibName: "CardViewController", bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.createButton.layer.cornerRadius = 8.0
		self.createButton.layer.borderWidth = 1.0
		self.createButton.layer.borderColor = UIColor.white.cgColor
		self.frontTextView.layer.cornerRadius = 5.0
		self.backTextView.layer.cornerRadius = 5.0
		
		let frontTextViewTapped = UITapGestureRecognizer(target: self, action: #selector(CardViewController.textTap(_:)))
		self.frontTextView.addGestureRecognizer(frontTextViewTapped)
		let backTextViewTapped = UITapGestureRecognizer(target: self, action: #selector(CardViewController.textTap(_:)))
		self.backTextView.addGestureRecognizer(backTextViewTapped)
    }

	@IBAction func createCard(_ sender: Any) {
		if self.frontTextView.text == "" || self.backTextView.text == "" {
			let incomplete = UIAlertController(title: "Missing Information", message: "Please fill out both fields.", preferredStyle: .alert)
			incomplete.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
			self.present(incomplete, animated: true, completion: nil)
		} else {
			let card = [self.frontTextView.text!, self.backTextView.text!]
			self.delegate?.newFlashcard(card)
			self.navigationController?.popViewController(animated: true)
		}
	}
	
	@objc func textTap(_ sender: UITextView) {
		if keyboard == true {
			sender.resignFirstResponder()
			self.keyboard = false
		} else {
			sender.becomeFirstResponder()
			self.keyboard = true        }
	}
	
}
