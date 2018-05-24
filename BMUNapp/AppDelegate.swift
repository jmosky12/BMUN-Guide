                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       //
//  AppDelegate.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/9/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit
import CoreData
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
	
	fileprivate let apiCommitteesURL = "https://api.mlab.com/api/1/databases/bmunguide/collections/BMUN?apiKey=JI0kCishO2bE688ivZhIUl-bv-UJ3bKg"
	fileprivate let apiTimelineURL = "https://api.mlab.com/api/1/databases/bmunguide/collections/Timeline?apiKey=JI0kCishO2bE688ivZhIUl-bv-UJ3bKg"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
        //Parse.setApplicationId("INbyDC9BcrJRZiBzuPT2p2oquTMZq9tuTiAqRNOf", clientKey: "FoOfryHoH7L6L6VMH0qltbZuAzE37D4e2PZDgoc3")
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        // Sets tab bar's view controllers and their properties on the tab bar
        let delegateGuide = DelegateGuideTableViewController()
        let delegateGuideNC = UINavigationController(rootViewController: delegateGuide)
        let item1 = UITabBarItem(title: "Guide", image: nil, tag: 1)
		Utils.setupTabBar(navController: delegateGuideNC, tabItem: item1, tabName: "Delegate Guide")
        
        let committees = CommitteesCollectionViewController()
        let committeesNC = UINavigationController(rootViewController: committees)
        let item2 = UITabBarItem(title: "Committees", image: nil, tag: 2)
		Utils.setupTabBar(navController: committeesNC, tabItem: item2, tabName: "Committees")
		
		let flashcards = FlashcardsViewController()
		let flashcardsNC = UINavigationController(rootViewController: flashcards)
		let item3 = UITabBarItem(title: "Flashcards", image: nil, tag: 3)
		Utils.setupTabBar(navController: flashcardsNC, tabItem: item3, tabName: "Flashcards")
	
        let info = InfoViewController()
        let infoNC = UINavigationController(rootViewController: info)
        let item4 = UITabBarItem(title: "Information", image: nil, tag: 4)
		Utils.setupTabBar(navController: infoNC, tabItem: item4, tabName: "Information")
    
        let connect = ConnectViewController()
        let connectNC = UINavigationController(rootViewController: connect)
        let item5 = UITabBarItem(title: "Connect", image: nil, tag: 5)
		Utils.setupTabBar(navController: connectNC, tabItem: item5, tabName: "Connect")

        let controllers = [delegateGuideNC, committeesNC, flashcardsNC, infoNC, connectNC]
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
        
        self.window?.addSubview(tabBarController.view)
        window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        // Sets characteristics for the tab bar at the bottom
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().isTranslucent = false
		
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.jmoskowitz.BMUNapp" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "BMUNapp", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

