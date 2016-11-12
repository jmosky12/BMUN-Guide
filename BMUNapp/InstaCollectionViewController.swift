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
    
    var imageList = [UIImage]();
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
        flowLayout.itemSize = CGSize(width: 200, height: 200)
        flowLayout.scrollDirection = .horizontal
        self.collectionView?.collectionViewLayout = flowLayout
        
        
        Alamofire.request("https://api.instagram.com/v1/users/self/media/recent/?access_token=191003028.24fe27c.f110d6acfe85455ca11ef9394ef9e691").responseJSON { response in
            if let JSON = response.result.value as? [String: AnyObject] {
                    let mediaData = (JSON["data"] as! [AnyObject])
                    for pic in mediaData {
                            let post = pic as! NSDictionary
                            let pictureData = post.object(forKey: "images") as! NSDictionary
                            let standardPic = pictureData.object(forKey: "standard_resolution") as! NSDictionary
                            let urlString = standardPic.object(forKey: "url")
                            self.stringList.append(urlString as! String)
                }
            }
        self.collectionView?.reloadData()
        }


        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stringList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as?
        InstaCollectionViewCell
        do {
            let urlPic = stringList[indexPath.row]
            let url = URL(string: urlPic)
            let picData = try Data(contentsOf: url!)
            let image = UIImage(data: picData)
            let imageView = UIImageView(image: image)
            cell?.image = imageView
            print(indexPath)
            print(cell)
            print(cell?.image)
            return cell!
        } catch {
            return cell!
        }
        
    }

}



//        let session = URLSession.shared
//        let instaURL = URL(string: https://api.instagram.com/v1/users/self/media/recent/?access_token=191003028.24fe27c.f110d6acfe85455ca11ef9394ef9e691)
//        let urlRequest = URLRequest(url:instaURL!);
//        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
//            guard error == nil else {
//                print("error calling GET on instagram")
//                print(error)
//                return
//            }
//            // make sure we got data
//            guard let responseData = data else {
//                print("Error: did not receive data")
//                return
//            }
//            do {
//                guard let insta = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
//                    print("error trying to convert data to JSON")
//                    return
//                }
//                let mediaData = (insta["data"] as! [AnyObject])
//                var x = 0
//                for pic in mediaData {
//                    if x < 5 {
//                        x += 1
//                        let post = pic as! NSDictionary
//                        let pictureData = post.object(forKey: "images") as! NSDictionary
//                        let standardPic = pictureData.object(forKey: "standard_resolution") as! NSDictionary
//                        let urlPic = standardPic.object(forKey: "url")
//                        let newUrl = URL(string: urlPic as! String)
////                        let picData = try Data(contentsOf: newUrl!)
//                        self.stringList.append((newUrl?.relativeString)!)
//                        print(":D")
//                    }
//                }
//                self.imagePrint()
//                self.collectionView?.reloadData()
//
//            } catch  {
//                print("error trying to convert data to JSON")
//                return
//            }
//        })
//        task.resume()



