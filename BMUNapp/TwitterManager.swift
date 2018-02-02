//
//  TwitterManager.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/31/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import Foundation
import STTwitter

class TwitterManager: NSObject {
    
    static let sharedInstance = TwitterManager()
    fileprivate let twitter: STTwitterAPI
    
    // Sets up our twitter access
    override init() {
        let consumerKey = "BfBhtc3rO3lJHdo5ES7YhJVWe"
        let consumerSecret = "FEqiPVMcQDT9DIk5oSkho0MnBKPyStydN8nPX3Jbz5ZwfHR0v2"
        twitter = STTwitterAPI(appOnlyWithConsumerKey: consumerKey, consumerSecret: consumerSecret)
        super.init()
        
    }
    
    // Authenticates our access to bmun's twitter
    func authenticate(_ cb: @escaping () -> ()) {
        twitter.verifyCredentials(userSuccessBlock: { (token: String?, userID: String?) -> Void in
            cb()
            }) { (error: Error?) -> Void in
				print("here's the error: \(String(describing: error))")
        }
    }
    
    // After authenticating using the wrapAuthenticate method, this accesses the berkeleyMUN twitter and returns a dictionary that contains all of our tweets and the details of each
    func getTweets(_ success: @escaping ([Tweet]) -> (), error: @escaping (Error?) -> ()) {
        wrapAuthenticate { [weak self] () -> () in
            self?.twitter.getUserTimeline(withScreenName: "berkeleyMUN", successBlock: { (response: [Any]?) -> Void in
                if let statuses = response as? [NSDictionary] {
                    success(statuses.map(Tweet.init).filter { $0 != nil }.map { $0! })
                } else {
                    success([])
                }
                }) { (err: Error?) -> Void in
                    error(err)
            }
        }
    }
    
    fileprivate func wrapAuthenticate(_ cb: @escaping () -> ()) {
        if isAuthenticated() {
            cb()
        } else {
            authenticate(cb)
        }
    }
    
    func isAuthenticated() -> Bool {
        return twitter.bearerToken != nil
    }
    
}
