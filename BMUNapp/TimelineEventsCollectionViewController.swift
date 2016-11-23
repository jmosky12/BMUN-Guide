//
//  TimelineEventsCollectionViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/12/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "timelineCell"

class TimelineEventsCollectionViewController: UICollectionViewController {
    
    var section: Int?
    
    init(section: Int) {
        self.section = section
        super.init(nibName: "TimelineEventsCollectionViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let nib: UINib = UINib(nibName: "TimelineCollectionViewCell", bundle: nil)
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
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let num: Int!
        switch(self.section!) {
        case 0:
            num = Storage.dayOneTimeline!.count - 1
        case 1:
            num = Storage.dayTwoTimeline!.count - 1
        case 2:
            num = Storage.dayThreeTimeline!.count - 1
        default:
            num = 0
        }
        return num
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let event = cell.viewWithTag(1) as? UILabel
        let time = cell.viewWithTag(2) as? UILabel
        var timeline: [String: Any]?
        
        switch(self.section!) {
        case 0:
            timeline = Storage.dayOneTimeline?[String(indexPath.row)] as? [String: Any]
            event?.text = timeline?["title"] as? String
            time?.text = timeline?["time"] as? String
        case 1:
            timeline = Storage.dayTwoTimeline?[String(indexPath.row)] as? [String: Any]
            event?.text = timeline?["title"] as? String
            time?.text = timeline?["time"] as? String
        case 2:
            timeline = Storage.dayThreeTimeline?[String(indexPath.row)] as? [String: Any]
            event?.text = timeline?["title"] as? String
            time?.text = timeline?["time"] as? String
        default:
            event?.text = "nil"
            time?.text = "nil"
        }
        return cell
    }
    
}
