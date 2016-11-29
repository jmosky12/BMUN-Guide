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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "View Cart", style: .plain, target: self,action: #selector(viewCartTapped))

        // Register cell classes
        
        let nib: UINib = UINib(nibName: "StoreCollectionViewCell", bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.hidesWhenStopped = true
        self.navigationController?.view.addSubview(activityIndicator)
        activityIndicator.center = (activityIndicator.superview?.center)!
        activityIndicator.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        activityIndicator.startAnimating()
    
        let width = self.view.bounds.width
        let flowLayout = CollectionViewFlowLayout()
        flowLayout.headerReferenceSize = CGSize(width: width, height: 20)
        flowLayout.footerReferenceSize = CGSize(width: width, height: 20)
        self.collectionView?.collectionViewLayout = flowLayout
        self.collectionView?.collectionViewLayout = flowLayout
        //Moltin stuff
        Moltin.sharedInstance().setPublicId("lT03XQXXnjSKcqWTR77B7oBc6ZTHXvCW6Qh9TfVdlT")
        Moltin.sharedInstance().product.listing(withParameters: ["limit": 100], success: { (response) -> Void in
            // products is an array of all of the products that match the parameters...
            self.products = response?["result"] as! [AnyObject]
            
            self.collectionView?.reloadData()
            activityIndicator.stopAnimating()
            
            }, failure: { (response, error) -> Void in
                print("Couldn't get products, something went wrong...")
        })
        
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

    func viewCartTapped() {
        let vc = CartTableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let vc = StoreDetailViewController(object: products[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
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
        let imageView = cell.viewWithTag(2) as? UIImageView
        label!.text = product["title"] as? String
        imageView?.image = UIImage(named: "bmun_hat.jpg")
    
        return cell
    }
    
}
