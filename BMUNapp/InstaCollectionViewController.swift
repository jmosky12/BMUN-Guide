//
//  InstaCollectionViewController.swift
//  BMUNapp
//
//  Created by Michael Eliot on 11/10/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


private let reuseIdentifier = "instaCell"

class InstaCollectionViewController: UICollectionViewController {
    
    var stringList = [String]();
    var image = UIImage();
    
    init() {
        super.init(nibName: "InstaCollectionViewController", bundle: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(InstaCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let nib: UINib = UINib(nibName: "InstaCollectionViewCell", bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    
        let flowLayout = UICollectionViewFlowLayout()
        let height = UIScreen.main.bounds.width - 40
        flowLayout.itemSize = CGSize(width: height, height: height + 100)
        flowLayout.scrollDirection = .vertical
        flowLayout.headerReferenceSize = CGSize(width: self.view.bounds.width, height: 20)
        flowLayout.footerReferenceSize = CGSize(width: self.view.bounds.width, height: 20)
        flowLayout.minimumLineSpacing = 20
        self.collectionView?.collectionViewLayout = flowLayout
        
        
        /*Alamofire.request("https://api.instagram.com/v1/users/self/media/recent/?access_token=191003028.24fe27c.f110d6acfe85455ca11ef9394ef9e691").responseJSON { response in
            if let JSON = response.result.value as? [String: AnyObject] {
                    let mediaData = (JSON["data"] as! [AnyObject])
                    for pic in mediaData {
                        let post = pic as! [String: Any]
                        let pictureData = post["images"] as! [String: Any]
                        let standardPic = pictureData["standard_resolution"] as! [String: Any]
                            let urlString = standardPic["url"] as! String
                            self.stringList.append(urlString)
                }
            }
        }*/


        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Storage.stringList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as?
        InstaCollectionViewCell
        DispatchQueue.global().async {
            () -> Void in
                do {
                        // Background thread
                    let urlPic = Storage.stringList[indexPath.row].urlString
                    let description = Storage.stringList[indexPath.row].description
                    let url = URL(string: urlPic)
                    let picData = try Data(contentsOf: url!)
                    DispatchQueue.main.async(execute: {
                        // UI Updates
                        let image = UIImage(data: picData)
                        cell?.imageView.image = image
                        cell?.imageView.clipsToBounds = true
                        cell?.imageView.contentMode = .scaleAspectFit
                        cell?.descriptionLabel.text = description
                        print(description)
                        cell?.descriptionLabel.sizeToFit()
                    })
                } catch {
                
                }
            }
        return cell!
        
    }

}
