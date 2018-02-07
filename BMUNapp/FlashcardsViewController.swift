//
//  FlashcardsViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 2/6/18.
//  Copyright © 2018 Jake Moskowitz. All rights reserved.
//

import UIKit

private let apiFlashcardsURL = "https://api.mlab.com/api/1/databases/bmunguide/collections/Flashcards?apiKey=JI0kCishO2bE688ivZhIUl-bv-UJ3bKg"

protocol FlashcardsViewControllerDelegate {
	func newFlashcard(_ card: [String])
}

class FlashcardsViewController: UIViewController {
	
	@IBOutlet var cardLabel: UILabel!
	@IBOutlet var addButton: UIButton!
	@IBOutlet var segmentedControl: UISegmentedControl!
	@IBOutlet var leftButton: UIButton!
	@IBOutlet var rightButton: UIButton!
	var currentCard: Array<String>?
	var bmunFlashcardsSet = false
	var spinner: UIActivityIndicatorView!
	var bmunCardCount: Int?
	var customCardCount: Int?
	var isBMUN = true
	var isFront = true
	
	
	init() {
		super.init(nibName: "FlashcardsViewController", bundle: nil)
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
		self.cardLabel.isHidden = true
		
		self.cardLabel.layer.cornerRadius = 8.0
		self.cardLabel.clipsToBounds = true
		
		self.spinner = UIActivityIndicatorView()
		self.view.addSubview(self.spinner)
		self.view.bringSubview(toFront: self.spinner)
		self.spinner.startAnimating()
		
		Storage.currentBmunIndex = Storage.currentBmunIndex != nil ? Storage.currentBmunIndex : 0
		Storage.currentCustomIndex = Storage.currentCustomIndex != nil ? Storage.currentCustomIndex : 0
		self.customCardCount = Storage.customFlashcards != nil ? Storage.customFlashcards?.count : 0
		
		let tapLeft = UITapGestureRecognizer(target: self, action: #selector(self.leftTapped(_:)))
		let tapRight = UITapGestureRecognizer(target: self, action: #selector(self.rightTapped(_:)))
		self.leftButton.addGestureRecognizer(tapLeft)
		self.rightButton.addGestureRecognizer(tapRight)
		let tapPhrase = UITapGestureRecognizer(target: self, action: #selector(FlashcardsViewController.togglePhrase(_:)))
		self.cardLabel.addGestureRecognizer(tapPhrase)
		
		let createButton = UIBarButtonItem(title: "Create New", style: .plain, target: self, action: #selector(self.createNewFlashcard))
		self.navigationController?.navigationItem.rightBarButtonItem = createButton
		self.navigationController?.navigationItem.rightBarButtonItem?.isEnabled = false
		
		if Storage.customFlashcards == nil {
			Storage.customFlashcards = NSMutableArray()
		}
		
		if Storage.noFlashcardsData {
			Storage.getRequest(URL(string: apiFlashcardsURL)!) {
				(data, response, error) in
				do {
					if data == nil {
						self.bmunFlashcardsSet = false
						self.bmunCardCount = 0
					} else {
						let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray
						let dict = json?[0] as? [String: Any]
						let flashcards = dict?["Flashcards"] as? [String: Any]
						for (key, _) in flashcards! {
							let pair = flashcards?[key] as? [String: String]
							let front = pair!["front"]
							let back = pair!["back"]
							let arr = [front, back] as! [String]
							Storage.bmunFlashcards.append(arr)
						}
						self.bmunFlashcardsSet = true
						Storage.noFlashcardsData = false
						DispatchQueue.main.async {
							self.spinner.stopAnimating()
							self.bmunCardCount = Storage.bmunFlashcards.count
							self.currentCard = Storage.bmunFlashcards[Storage.currentBmunIndex!]
							self.cardLabel.text = self.currentCard?[0]
							self.cardLabel.isHidden = false
//							self.isButtonDisabled()
						}
					}
				} catch _ {
					self.bmunFlashcardsSet = false
//					self.collectionView?.reloadData()
				}
			}
		}
    }
	
	@IBAction func segmentClicked(_ sender: UISegmentedControl) {
		self.isBMUN = sender.selectedSegmentIndex == 0 ? true : false
		if !self.isBMUN {
			self.navigationController?.navigationItem.rightBarButtonItem?.isEnabled = true
			if self.customCardCount == 0 {
				self.cardLabel.text = "Click to Create Flashcards"
			} else {
				self.currentCard = Storage.customFlashcards?[Storage.currentCustomIndex!] as? Array<String>
				self.cardLabel.text = self.currentCard?[0]
			}
		} else {
			self.navigationController?.navigationItem.rightBarButtonItem?.isEnabled = false
		}
	}
	
//	func isButtonDisabled() {
//		if self.isBMUN {
//			if Storage.currentBmunIndex == 0 {
//				self.leftButton.isEnabled = false
//			}
//			if Storage.currentBmunIndex! == self.bmunCardCount! - 1 {
//				self.rightButton.isEnabled = false
//			} else {
//				self.leftButton.isEnabled = true
//				self.rightButton.isEnabled = true
//			}
//		}
//	}
	
	@objc func togglePhrase(_ sender: UITapGestureRecognizer) {
		if self.isBMUN || self.customCardCount! > 0 {
			self.isFront = !self.isFront
			self.cardLabel.text = self.isFront ? self.currentCard![0] : self.currentCard![1]
		} else {
			self.createNewFlashcard()
		}
	}
	
	@objc func leftTapped(_ sender: UITapGestureRecognizer) {
		if self.isBMUN {
			if self.bmunFlashcardsSet && Storage.currentBmunIndex! > 0 {
				Storage.currentBmunIndex! -= 1
				self.currentCard = Storage.bmunFlashcards[Storage.currentBmunIndex!]
				self.cardLabel.text = self.currentCard?[0]
				self.isFront = true
			}
		}
//		self.isButtonDisabled()
	}
	
	@objc func rightTapped(_ sender: UITapGestureRecognizer) {
		if self.isBMUN {
			if self.bmunFlashcardsSet && Storage.currentBmunIndex! < self.bmunCardCount! - 1 {
				Storage.currentBmunIndex! += 1
				self.currentCard = Storage.bmunFlashcards[Storage.currentBmunIndex!]
				self.cardLabel.text = self.currentCard?[0]
				self.isFront = true
			}
		}
//		self.isButtonDisabled()
	}
	
	@objc func createNewFlashcard() {
		let vc = CardViewController()
		vc.delegate = self as? FlashcardsViewControllerDelegate
		self.navigationController!.pushViewController(vc, animated: true)
	}
	
	//MARK: Delegate
	
	func newFlashcard(_ card: Array<String>) {
		Storage.customFlashcards?.add(card)
		if self.customCardCount == 0 {
			self.customCardCount! += 1
			self.currentCard = Storage.customFlashcards![Storage.currentCustomIndex!] as? Array<String>
			self.cardLabel.text = self.currentCard?[0]
		}
	}
	
}
