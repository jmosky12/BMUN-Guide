//
//  Storage.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/26/16.
//  Copyright © 2016 Jake Moskowitz. All rights reserved.
//

import Foundation
import SwiftyJSON

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
	
    static var bmunBlue = UIColor.init(red: 24/256, green: 73/256, blue: 140/256, alpha: 1)
	
	static var lightBlue = UIColor.init(red: 33/256, green: 145/256, blue: 197/256, alpha: 1)
	
    static var blocACommittees: [String: Any]?
	
    static var blocBCommittees: [String: Any]?
	
    static var specializedCommittees: [String: Any]?
	
    static var crisisCommittees: [String: Any]?
	
    static var blocACount: Int?
	
    static var blocBCount: Int?
	
    static var specializedCount: Int?
	
    static var crisisCount: Int?
	
    static var dayOneTimeline: [String: Any]?
	
    static var dayTwoTimeline: [String: Any]?
	
    static var dayThreeTimeline: [String: Any]?
    
    static var instaList: [InstagramInfo]!
	
	static var instaHeights: [CGFloat] = []
    
    //static var committees: Array<AnyObject>?
}

struct InstagramInfo {
    var urlString: String
    var description: String
}
