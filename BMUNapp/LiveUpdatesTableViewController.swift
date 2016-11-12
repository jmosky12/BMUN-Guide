//
//  LiveUpdatesViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/12/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit
import DateTools

class LiveUpdatesTableViewController: UIViewController, UITableViewDataSource {
    
    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet] = []
    var refreshControl: UIRefreshControl!
    
    init() {
        super.init(nibName: "LiveUpdatesTableViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
        
        refreshControl = UIRefreshControl()
        tableView.insertSubview(refreshControl, at: 0)
        refreshControl.addTarget(self, action: #selector(LiveUpdatesTableViewController.getTweets(_:)), for: .valueChanged)
        
        getTweets(nil)
        
        edgesForExtendedLayout = UIRectEdge()
        
        // Ensures table cell separators are set up correctly
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.preservesSuperviewLayoutMargins = false
        tableView.layoutMargins = UIEdgeInsets.zero
        
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let nib: UINib = UINib(nibName: "LiveUpdatesTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "liveUpdates")
        
        // Sets characteristics for top bar text
        let textColor = UIColor.white
        let textFont = UIFont(name: "Avenir", size: 35.0)
        let titleTextAttributes: [String:NSObject] = [
            NSFontAttributeName: textFont!,
            NSForegroundColorAttributeName: textColor,
        ]
        self.navigationController!.navigationBar.titleTextAttributes = titleTextAttributes
    }
    
    // These two functions below prevent landscape mode
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.portrait]
    }

    // Creates a shared instance of the Twitter Manager (A class that will only ever be called once) and uses getTweets to get an array of tweets and set it to the tweets variable at the top
    func getTweets(_ sender: AnyObject!) {
        if sender != nil {
            refreshControl.beginRefreshing()
        }
        TwitterManager.sharedInstance.getTweets({ [weak self] (tweets: [Tweet]) -> () in
            self?.tweets = tweets
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
            }) { [weak self](error: Error?) -> () in
                self?.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    // Iterates through the tweets array and populates the table cells with each tweet
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "liveUpdates") as! LiveUpdatesTableViewCell
        let tweet = tweets[(indexPath as NSIndexPath).row]
        
        cell.tweetText.text = tweet.text
        let date = NSDate(string: tweet.strDate!, formatString: "EEE MMM d HH:mm:ss Z y")
        cell.date.text = String(describing: date!.shortTimeAgoSinceNow)
        cell.screenName.text = "@\(tweet.screenName!)"
        cell.userName.text = tweet.username
        cell.avatar.image = UIImage(named: "twitterAvatar")
        
        return cell
    }
    
}
