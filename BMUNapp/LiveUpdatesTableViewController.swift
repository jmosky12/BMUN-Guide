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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        
        self.activityIndicator.startAnimating()
        getTweets(nil)
        
        edgesForExtendedLayout = UIRectEdge()
        
        // Ensures table cells are set up correctly
        Utils.setupTableView(tableView: self.tableView, rowHeight: 140)
        self.tableView.dataSource = self
        
        let nib: UINib = UINib(nibName: "LiveUpdatesTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "liveUpdates")
        
        // Sets characteristics for top bar text
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.black
    }


    // Creates a shared instance of the Twitter Manager (A class that will only ever be called once) and uses getTweets to get an array of tweets and set it to the tweets variable at the top
    @objc func getTweets(_ sender: AnyObject!) {
        if sender != nil {
            refreshControl.beginRefreshing()
        }
        TwitterManager.sharedInstance.getTweets({ [weak self] (tweets: [Tweet]) -> () in
            self?.tweets = tweets
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
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
		
        cell.date.text = String(describing: Storage.timeAgoSinceDate(date: date!, numericDates: true))
        cell.screenName.text = "@\(tweet.screenName!)"
        cell.userName.text = tweet.username
        cell.avatar.image = UIImage(named: "twitterAvatar")
        
        return cell
    }
    
}
