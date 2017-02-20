//
//  TimelineCollectionViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "committeeCollectionCell"
private let apiTimelineURL = "https://api.mlab.com/api/1/databases/bmunguide/collections/Timeline?apiKey=JI0kCishO2bE688ivZhIUl-bv-UJ3bKg"

class TimelineCollectionViewController: UICollectionViewController {
	
	var timelineSet = false
	var spinner: UIActivityIndicatorView!
	var noDataLabel: UILabel!
    
    init() {
        super.init(nibName: "TimelineCollectionViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let nib: UINib = UINib(nibName: "CommitteesCollectionViewCell", bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        let width = self.view.bounds.width
        let flowLayout = CollectionViewFlowLayout()
        flowLayout.headerReferenceSize = CGSize(width: width, height: 20)
        flowLayout.footerReferenceSize = CGSize(width: width, height: 20)
        self.collectionView?.collectionViewLayout = flowLayout
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        
        self.collectionView?.allowsSelection = true
        self.collectionView?.allowsMultipleSelection = false
		
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
		self.spinner.activityIndicatorViewStyle = .whiteLarge
		self.collectionView?.addSubview(view)
		self.spinner.startAnimating()
		
		if Storage.noTimelineData {
			Storage.getRequest(URL(string: apiTimelineURL)!) {
				(data, response, error) in
				do {
					if data == nil {
						self.timelineSet = true
						self.view.bringSubview(toFront: self.noDataLabel)
						self.collectionView?.reloadData()
					} else {
						let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray
						let dict = json?[0] as? [String: Any]
						let timeline = dict?["Timeline"] as? [String: Any]
						for (key, _) in timeline! {
							if key == "0" {
								Storage.dayOneTimeline = (timeline?[key] as? [String: Any])!
							} else if key == "1" {
								Storage.dayTwoTimeline = (timeline?[key] as? [String: Any])!
							} else {
								Storage.dayThreeTimeline = (timeline?[key] as? [String: Any])!
							}
						}
						self.timelineSet = true
						Storage.noTimelineData = false
						self.collectionView?.reloadData()
					}
				} catch _ {
					self.timelineSet = false
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
		if Storage.noTimelineData && !self.timelineSet {
			return 0
		} else if Storage.noTimelineData && self.timelineSet {
			self.spinner.stopAnimating()
			self.noDataLabel.isHidden = false
			return 0
		} else {
			self.spinner.stopAnimating()
			return 3
		}
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let imageView = cell.viewWithTag(1) as? UIImageView
        switch(indexPath.row) {
        case 0:
            imageView?.image = UIImage(named: "march3")
        case 1:
            imageView?.image = UIImage(named: "march4")
        case 2:
            imageView?.image = UIImage(named: "march5")
        default:
            imageView?.image = UIImage(named: "march3")
        }
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TimelineEventTableViewController(section: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
}
