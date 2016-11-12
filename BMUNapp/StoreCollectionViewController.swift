//
//  StoreCollectionViewController.swift
//  BMUNapp
//
//  Created by Michael Eliot on 10/2/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit
import Moltin

private let reuseIdentifier = "storeCell"

class StoreCollectionViewController: UICollectionViewController {
    var products = [AnyObject]()
    
    init() {
        super.init(nibName: "StoreCollectionViewController", bundle: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(StoreCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let nib: UINib = UINib(nibName: "StoreCollectionViewCell", bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 200, height: 200)
        flowLayout.scrollDirection = .horizontal
        self.collectionView?.collectionViewLayout = flowLayout
        
        //Moltin stuff
        Moltin.sharedInstance().setPublicId("lT03XQXXnjSKcqWTR77B7oBc6ZTHXvCW6Qh9TfVdlT")
        Moltin.sharedInstance().product.listing(withParameters: ["limit": 100], success: { (response) -> Void in
            // products is an array of all of the products that match the parameters...
            self.products = response?["result"] as! [AnyObject]
            //print("Got products: \(self.products)")
            
            self.collectionView?.reloadData()
            
            }, failure: { (response, error) -> Void in
                print("Couldn't get products, something went wrong...")
                print(error)
        })
    
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        let product = products[(indexPath as NSIndexPath).row] as! [String:AnyObject]
        let label = cell.viewWithTag(1) as? UILabel
        label!.text = product["title"] as? String
    
        return cell
    }
    
}
