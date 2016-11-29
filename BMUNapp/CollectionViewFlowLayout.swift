//
//  CollectionViewFlowLayout.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/23/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    let height = UIScreen.main.bounds.width - 40
    
    override var itemSize: CGSize {
        set {}
        get {
            return CGSize(width: self.height, height: self.height)
        }
    }
    
    override var minimumLineSpacing: CGFloat {
        set {}
        get {
            return 20
        }
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
