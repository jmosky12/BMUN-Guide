//
//  CommitteeDetailViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 12/8/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class CommitteeDetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var headChairLabel: UILabel!
    @IBOutlet weak var viceChairsLabel: UILabel!
    @IBOutlet weak var topicsLabel: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    var indexPathRow: Int!
    var indexPathSection: Int!
    var committee: [String: Any]?
    
    // Intitializes with the tag specified in CommitteeTableViewController.swift's didSelectRowAtIndexPath methof
    init(section: Int, row: Int) {
        //self.tag = tag
        self.indexPathRow = row
        self.indexPathSection = section
        super.init(nibName: "CommitteeDetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        
        // Sets the labels' info based on the committee info in storage
        switch(self.indexPathSection) {
        case 0:
            committee = Storage.blocACommittees[String(self.indexPathRow)] as! [String : Any]?
            self.topicsLabel.text = committee?["Topics"] as? String
            self.headChairLabel.text = committee?["Head Chair"] as? String
            self.viceChairsLabel.text = committee?["Vice Chairs"] as? String
        case 1:
            committee = Storage.blocBCommittees[String(self.indexPathRow)] as! [String : Any]?
            self.topicsLabel.text = committee?["Topics"] as? String
            self.headChairLabel.text = committee?["Head Chair"] as? String
            self.viceChairsLabel.text = committee?["Vice Chairs"] as? String
        case 2:
            committee = Storage.specializedCommittees[String(self.indexPathRow)] as! [String : Any]?
            self.topicsLabel.text = committee?["Topics"] as? String
            self.headChairLabel.text = committee?["Head Chair"] as? String
            self.viceChairsLabel.text = committee?["Vice Chairs"] as? String
        case 3:
            committee = Storage.crisisCommittees[String(self.indexPathRow)] as! [String : Any]?
            self.topicsLabel.text = committee?["Topics"] as? String
            self.headChairLabel.text = committee?["Head Chair"] as? String
            self.viceChairsLabel.text = committee?["Vice Chairs"] as? String
        default:
            self.topicsLabel.text = "Hit Default"
            self.headChairLabel.text = "Hit Default"
            self.viceChairsLabel.text = "Hit Default"
        }

        self.topicsLabel.sizeToFit()
        self.viceChairsLabel.sizeToFit()
        self.headChairLabel.sizeToFit()
        
        self.backgroundImageView.image = UIImage(named: "background")
        self.backgroundImageView.contentMode = .scaleAspectFill
        self.backgroundImageView.alpha = 0.85
        
        self.websiteButton.clipsToBounds = true
        self.websiteButton.layer.cornerRadius = 5
        self.websiteButton.layer.borderWidth = 1
        self.websiteButton.layer.borderColor = UIColor.white.cgColor
      
    }
    
    // These two functions below prevent landscape mode
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.portrait]
    }

    @IBAction func synopsisSelected(_ sender: UIButton) {
        let stringURL = committee?["Website"] as? String
        let url = URL(string: stringURL!)
		UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }

}
