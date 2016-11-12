//
//  Tweet.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/31/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import Foundation

class Tweet: NSObject {
    
    let username: String!
    let text: String!
    let createdAt: Date?
    let profileImageURL: URL?
    let screenName: String!
    var strDate: String?
    
    // Using the dictionary of tweets and their details from TwitterManager.swift, this selects the important characteristics and assigns them to the constants above
    init?(dict: NSDictionary) {
        if let user = dict["user"] as? NSDictionary, let txt = dict["text"] as? String, let crt = dict["created_at"] as? String {
            text = txt
            createdAt = DateFormatterManager.sharedInstance.format(crt)
            strDate = crt
            if let name = user["name"] as? String, let imageURL = user["profile_image_url"] as? String, let sn = user["screen_name"] as? String {
                username = name
                screenName = sn
                profileImageURL = URL(string: imageURL)
            } else {
                username = nil
                screenName = nil
                profileImageURL = nil
                strDate = nil
            }
        } else {
            text = nil
            username = nil
            screenName = nil
            createdAt = nil
            profileImageURL = nil
            strDate = nil
        }
        
        super.init()
        
        if username.isEmpty { return nil }
        if text.isEmpty { return nil }
        if screenName.isEmpty { return nil }
    }
}
