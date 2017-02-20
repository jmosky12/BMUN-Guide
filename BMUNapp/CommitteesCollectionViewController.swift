//
//  CommitteesCollectionViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "committeeCollectionCell"
private let apiCommitteesURL = "https://api.mlab.com/api/1/databases/bmunguide/collections/BMUN?apiKey=JI0kCishO2bE688ivZhIUl-bv-UJ3bKg"

class CommitteesCollectionViewController: UICollectionViewController {
    
    init() {
        super.init(nibName: "CommitteesCollectionViewController", bundle: nil)
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
        
        let textColor = UIColor.white
        let textFont = UIFont(name: "Avenir", size: 35.0)
        let titleTextAttributes: [String:NSObject] = [
            NSFontAttributeName: textFont!,
            NSForegroundColorAttributeName: textColor,
            ]
        self.navigationController!.navigationBar.titleTextAttributes = titleTextAttributes
        self.collectionView?.allowsSelection = true
        self.collectionView?.allowsMultipleSelection = false
		
		Storage.getRequest(URL(string: apiCommitteesURL)!) {
			(data, response, error) in
			do {
				if data == nil {
					Storage.noData = true
					return
				}
				Storage.noData = false
				let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray
				let dict = json?[0] as? [String: Any]
				let committees = dict?["Committee"] as? [String: Any]
				for (key, _) in committees! {
					if key == "0" {
						Storage.blocACommittees = committees?[key] as? [String: Any]
					} else if key == "1" {
						Storage.blocBCommittees = committees?[key] as? [String: Any]
					} else if key == "2" {
						Storage.specializedCommittees = committees?[key] as? [String: Any]
					} else {
						Storage.crisisCommittees = committees?[key] as? [String: Any]
					}
				}
			} catch _ {
				Storage.noData = true
			}
		}

		
        /*self.collectionView?.backgroundView = UIImageView(frame: (self.collectionView?.frame)!)
        let imageView = self.collectionView?.backgroundView as! UIImageView
        imageView.image = UIImage(named: "blah")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.85*/
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let imageView = cell.viewWithTag(1) as? UIImageView
        switch(indexPath.row) {
        case 0:
            imageView?.image = UIImage(named: "blocA")
        case 1:
            imageView?.image = UIImage(named: "blocB")
        case 2:
            imageView?.image = UIImage(named: "specialized")
        case 3:
            imageView?.image = UIImage(named: "crisis")
        default:
            imageView?.image = UIImage(named: "blocA")
        }
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SpecificCommitteeCollectionViewController(section: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
}
