//
//  ConferenceChoicesViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/9/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class ConferenceChoicesViewController: UIViewController {
    
    @IBOutlet weak var longLogoIV: UIImageView!
    @IBOutlet weak var bmunLogo1: UIImageView!
    @IBOutlet weak var bmunLogo2: UIImageView!
    @IBOutlet weak var bmunLogo3: UIImageView!
    @IBOutlet weak var committeesButton: UIButton!
    @IBOutlet weak var timelineButton: UIButton!
    @IBOutlet weak var liveUpdatesButton: UIButton!
    @IBOutlet weak var committeesLabel: NSLayoutConstraint!
    @IBOutlet weak var timelineLabel: NSLayoutConstraint!
    @IBOutlet weak var liveUpdatesLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longLogo = UIImage(named: "startinglonglogo")
        let bmunLogo = UIImage(named: "bmunlogo")
        
        longLogoIV.contentMode = UIViewContentMode.ScaleAspectFit
        longLogoIV.clipsToBounds = true
        longLogoIV.image = longLogo
        
        bmunLogo1.contentMode = UIViewContentMode.ScaleAspectFit
        bmunLogo1.clipsToBounds = true
        bmunLogo1.image = bmunLogo
        
        bmunLogo2.contentMode = UIViewContentMode.ScaleAspectFit
        bmunLogo2.clipsToBounds = true
        bmunLogo2.image = bmunLogo
        
        bmunLogo3.contentMode = UIViewContentMode.ScaleAspectFit
        bmunLogo3.clipsToBounds = true
        bmunLogo3.image = bmunLogo
        
        liveUpdatesLabel.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        liveUpdatesLabel.titleLabel?.textAlignment = NSTextAlignment.Center
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 253.0/255.0, green: 253.0/255.0, blue: 253.0/255.0, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

}
