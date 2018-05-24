//
//  Storage.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/26/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import Foundation
import UIKit


private let defaults = UserDefaults.standard

struct Storage {
    static func getRequest(_ url: URL, onResponse: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url as URL, completionHandler: onResponse).resume()
    }
	
	static func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
		let calendar = NSCalendar.current
		let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
		let now = NSDate()
		let earliest = now.earlierDate(date as Date)
		let latest = (earliest == now as Date) ? date : now
		let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
		
		if (components.year! >= 2) {
			return "\(components.year!) years"
		} else if (components.year! >= 1){
		if (numericDates){
			return "1 year"
		} else {
			return "Last year"
		}
		} else if (components.month! >= 2) {
			return "\(components.month!) months"
		} else if (components.month! >= 1){
		if (numericDates){
			return "1 month"
		} else {
			return "Last month"
		}
		} else if (components.weekOfYear! >= 2) {
			return "\(components.weekOfYear!) weeks"
		} else if (components.weekOfYear! >= 1){
		if (numericDates){
			return "1 week"
		} else {
			return "Last week"
		}
		} else if (components.day! >= 2) {
			return "\(components.day!) days"
		} else if (components.day! >= 1){
		if (numericDates){
			return "1 day"
		} else {
			return "Yesterday"
		}
		} else if (components.hour! >= 2) {
			return "\(components.hour!) hrs"
		} else if (components.hour! >= 1){
		if (numericDates){
			return "1 hr"
		} else {
			return "An hour ago"
		}
		} else if (components.minute! >= 2) {
			return "\(components.minute!) mins"
		} else if (components.minute! >= 1){
		if (numericDates){
			return "1 min"
		} else {
			return "A minute ago"
		}
		} else if (components.second! >= 3) {
			return "\(components.second!) secs"
		} else {
			return "Just now"
		}
		
	}
	
    static var bmunBlue = UIColor.init(red: 29/256, green: 146/256, blue: 198/256, alpha: 1)
	
	static var lightGray = UIColor.init(red: 239/256, green: 239/256, blue: 244/256, alpha: 1)
	
	static var lightBlue = UIColor.init(red: 42/256, green: 165/256, blue: 209/256, alpha: 1)
	
	static var blocACommittees: [String: Any] = [:]
	
    static var blocBCommittees: [String: Any] = [:]
	
    static var specializedCommittees: [String: Any] = [:]
	
    static var crisisCommittees: [String: Any] = [:]
	
    static var blocACount: Int = 0
	
    static var blocBCount: Int = 0
	
    static var specializedCount: Int = 0
	
    static var crisisCount: Int = 0
	
    static var dayOneTimeline: [String: Any] = [:]
	
    static var dayTwoTimeline: [String: Any] = [:]
	
    static var dayThreeTimeline: [String: Any] = [:]
	
	static var noCommitteeData = true
	
	static var noTimelineData = true
	
	static var noFlashcardsData = true
	
	static var customFlashcards: [[String]]? {
		set {
			defaults.setValue(newValue, forKey: "customFlashcards")
		}
		get {
			return defaults.array(forKey: "customFlashcards") as? [[String]]
		}
	}
	
	static var bmunFlashcards: [[String]]? = []
	
	static var currentCustomIndex: Int? {
		set {
			defaults.setValue(newValue, forKey: "currentCustomIndex")
		}
		get {
			return defaults.integer(forKey: "currentCustomIndex") as Int?
		}
	}
	
	static var currentBmunIndex: Int? {
		set {
			defaults.setValue(newValue, forKey: "currentBmunIndex")
		}
		get {
			return defaults.integer(forKey: "currentBmunIndex") as Int?
		}
	}
	
	static var tabTitleTextAttributes: [NSAttributedStringKey:Any] = [
		NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont(name: "Avenir", size: 13.0)!
	]
}

struct InstagramInfo {
    var urlString: String
    var description: String
}
