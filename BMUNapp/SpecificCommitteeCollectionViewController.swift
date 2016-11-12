//
//  SpecificCommitteeCollectionViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "specificCommitteeCell"

class SpecificCommitteeCollectionViewController: UICollectionViewController {
    
    var section: Int?
    
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
        
        let flowLayout = UICollectionViewFlowLayout()
        let height = UIScreen.main.bounds.width - 40
        flowLayout.itemSize = CGSize(width: height, height: height)
        flowLayout.scrollDirection = .vertical
        flowLayout.headerReferenceSize = CGSize(width: self.view.bounds.width, height: 20)
        flowLayout.footerReferenceSize = CGSize(width: self.view.bounds.width, height: 20)
        flowLayout.minimumLineSpacing = 20
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
        
        self.navigationController?.navigationBar.tintColor = UIColor.white

    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let num: Int!
        switch(self.section!) {
        case 0:
            num = Storage.blocACommittees?.count
        case 1:
            num = Storage.blocBCommittees?.count
        case 2:
            num = Storage.specializedCommittees?.count
        case 3:
            num = Storage.crisisCommittees?.count
        default:
            num = 0
        }
        return num
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let imageView = cell.viewWithTag(1) as? UIImageView
        var committee: [String: Any]?
        var imgTitle: String?

        switch(self.section!) {
        case 0:
            committee = Storage.blocACommittees?[String(indexPath.row)] as! [String : Any]?
            imgTitle = committee?["img"] as? String
        case 1:
            committee = Storage.blocBCommittees?[String(indexPath.row)] as! [String : Any]?
            imgTitle = committee?["img"] as? String
        case 2:
            committee = Storage.specializedCommittees?[String(indexPath.row)] as! [String : Any]?
            imgTitle = committee?["img"] as? String
        case 3:
            committee = Storage.crisisCommittees?[String(indexPath.row)] as! [String : Any]?
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
