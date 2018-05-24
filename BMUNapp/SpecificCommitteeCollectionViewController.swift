//
//  SpecificCommitteeCollectionViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "specificCommitteeCell"
private let apiCommitteesURL = "https://api.mlab.com/api/1/databases/bmunguide/collections/BMUN?apiKey=JI0kCishO2bE688ivZhIUl-bv-UJ3bKg"

class SpecificCommitteeCollectionViewController: UICollectionViewController {
    
    var section: Int?
	var committeesSet = false
	var spinner: UIActivityIndicatorView!
	var noDataLabel: UILabel!
    
    init(section: Int) {
        self.section = section
        super.init(nibName: "SpecificCommitteeCollectionViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let nib: UINib = UINib(nibName: "SpecificCommitteeCollectionViewCell", bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
		Utils.setupCollectionView(colView: self.collectionView!, view: self.view)
		
        self.view.clipsToBounds = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
		
		let view = UIView(frame: CGRect(x: (self.view.frame.width/2), y: 0, width: 100, height: 100))
		view.center.y = (self.collectionView?.center.y)!
		
		self.noDataLabel = UILabel()
		self.noDataLabel.frame = CGRect(x: 0, y: 0, width: (self.collectionView?.frame.width)!, height: 40)
		self.noDataLabel.center = (self.collectionView?.center)!
		self.noDataLabel.numberOfLines = 0
		self.noDataLabel.text = "Please resolve the network connection."
		self.noDataLabel.isHidden = true
		self.noDataLabel.textColor = UIColor.white
		self.noDataLabel.textAlignment = .center
		self.view.addSubview(self.noDataLabel)
		
		self.spinner = UIActivityIndicatorView()
		view.addSubview(self.spinner)
		self.spinner.activityIndicatorViewStyle = .gray
		self.collectionView?.addSubview(view)
		self.spinner.startAnimating()
		
		// pulls in committee data if not set yet
		if Storage.noCommitteeData {
			Storage.getRequest(URL(string: apiCommitteesURL)!) {
				(data, response, error) in
				do {
					if data == nil {
						self.committeesSet = true
						self.view.bringSubview(toFront: self.noDataLabel)
						self.collectionView?.reloadData()
					} else {
						let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray
						let dict = json?[0] as? [String: Any]
						let committees = dict?["Committee"] as? [String: Any]
						for (key, _) in committees! {
							if key == "0" {
								Storage.blocACommittees = (committees?[key] as? [String: Any])!
							} else if key == "1" {
								Storage.blocBCommittees = (committees?[key] as? [String: Any])!
							} else if key == "2" {
								Storage.specializedCommittees = (committees?[key] as? [String: Any])!
							} else {
								Storage.crisisCommittees = (committees?[key] as? [String: Any])!
							}
						}
						self.committeesSet = true
						Storage.noCommitteeData = false
						DispatchQueue.main.async {
							self.collectionView?.reloadData()
						}
					}
				} catch _ {
					self.committeesSet = false
					self.collectionView?.reloadData()
				}
			}
		}
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
	
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if Storage.noCommitteeData && !self.committeesSet {
			return 0
		} else if Storage.noCommitteeData && self.committeesSet {
			self.spinner.stopAnimating()
			self.noDataLabel.isHidden = false
			return 0
		} else {
			self.spinner.stopAnimating()
			let num: Int!
			switch(self.section!) {
			case 0:
				num = Storage.blocACommittees.count
			case 1:
				num = Storage.blocBCommittees.count
			case 2:
				num = Storage.specializedCommittees.count
			case 3:
				num = Storage.crisisCommittees.count
			default:
				num = 0
			}
			return num
		}
    }
	
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let imageView = cell.viewWithTag(1) as? UIImageView
        var committee: [String: Any]?
        var imgTitle: String?

        switch(self.section!) {
        case 0:
            committee = Storage.blocACommittees[String(indexPath.row)] as! [String : Any]?
            imgTitle = committee?["img"] as? String
        case 1:
            committee = Storage.blocBCommittees[String(indexPath.row)] as! [String : Any]?
            imgTitle = committee?["img"] as? String
        case 2:
            committee = Storage.specializedCommittees[String(indexPath.row)] as! [String : Any]?
            imgTitle = committee?["img"] as? String
        case 3:
            committee = Storage.crisisCommittees[String(indexPath.row)] as! [String : Any]?
            imgTitle = committee?["img"] as? String
        default:
            imgTitle = "nil"
        }
        imageView?.image = UIImage(named: imgTitle!)
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CommitteeDetailViewController(section: self.section!, row: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
