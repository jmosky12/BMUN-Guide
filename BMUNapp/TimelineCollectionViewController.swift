//
//  TimelineCollectionViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "committeeCollectionCell"

class TimelineCollectionViewController: UICollectionViewController {
    
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
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
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
