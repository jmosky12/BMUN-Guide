//
//  CardViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 2/6/18.
//  Copyright © 2018 Jake Moskowitz. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, UITextViewDelegate {
	
	@IBOutlet var frontTextView: UITextView!
	@IBOutlet var backTextView: UITextView!
	@IBOutlet var createButton: UIButton!
	
	var keyboard = false
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
		self.frontTextView.delegate = self
		self.backTextView.delegate = self
		
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
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if text == "\n" {
			textView.resignFirstResponder()
			return false
		}
		return true
	}
	
}
