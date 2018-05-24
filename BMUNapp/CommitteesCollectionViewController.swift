//
//  CommitteesCollectionViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "committeeCollectionCell"

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
		Utils.setupCollectionView(colView: self.collectionView!, view: self.view)
        
        self.navigationController!.navigationBar.titleTextAttributes = Utils.getTitleTextAttributes(fontName: "Avenir", fontSize: 35.0, textColor: UIColor.white)
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
    
}
