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
    static func getRequest(url: NSURL, onResponse: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url as URL, completionHandler: onResponse).resume()
    }
    
    static var blocACommittees: [String: Any]?
    static var blocBCommittees: [String: Any]?
    static var specializedCommittees: [String: Any]?
    static var crisisCommittees: [String: Any]?
    static var blocACount: Int?
    static var blocBCount: Int?
    static var specializedCount: Int?
    static var crisisCount: Int?
    
    //static var committees: Array<AnyObject>?
}
