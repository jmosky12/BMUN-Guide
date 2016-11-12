//
//  DateFormatterManager.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/31/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import Foundation

// Makes the "time ago" detail of each tweet formatted correctly

class DateFormatterManager: NSObject {
    
    static let sharedInstance = DateFormatterManager()
    
    let formatter = DateFormatter()
    let prettyFormatter = DateFormatter()
    
    override init() {
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        prettyFormatter.dateStyle = .short
        prettyFormatter.timeStyle = .short
        super.init()
    }
    
    func pretty(_ date: Date) -> String {
        return prettyFormatter.string(from: date)
    }
    
    func format(_ s: String) -> Date? {
        return formatter.date(from: s)
    }
    
}
