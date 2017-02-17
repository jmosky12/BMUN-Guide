//
//  InfoViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 11/22/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var timelineIV: UIImageView!
    @IBOutlet weak var questionsIV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionsIV.image = UIImage(named: "questions")
        timelineIV.image = UIImage(named: "timeline")
        
        questionsIV.clipsToBounds = true
        timelineIV.clipsToBounds = true
        
        questionsIV.layer.cornerRadius = 50
        timelineIV.layer.cornerRadius = 50
        
        let questionsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InfoViewController.questionsSelected))
        let timelineGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InfoViewController.timelineSelected))
        
        questionsIV.addGestureRecognizer(questionsGestureRecognizer)
        timelineIV.addGestureRecognizer(timelineGestureRecognizer)
        
        let textColor = UIColor.white
        let textFont = UIFont(name: "Avenir", size: 35.0)
        let titleTextAttributes: [String:NSObject] = [
            NSFontAttributeName: textFont!,
            NSForegroundColorAttributeName: textColor,
            ]
        self.navigationController!.navigationBar.titleTextAttributes = titleTextAttributes
    }

    func questionsSelected() {
        let vc = QuestionsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func timelineSelected() {
        let vc = TimelineCollectionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
