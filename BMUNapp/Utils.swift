//
//  Utils.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 5/23/18.
//  Copyright © 2018 Jake Moskowitz. All rights reserved.
//

import UIKit

struct Utils {
	
	static func getTitleTextAttributes(fontName: String, fontSize: CGFloat, textColor: UIColor) -> [NSAttributedStringKey:Any] {
		let textFont = UIFont(name: fontName, size: fontSize)
		return [
			NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): textFont!,
			NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): textColor,
			]
	}
	
	static func setupTableView(tableView: UITableView, rowHeight: Int) {
		tableView.separatorInset = UIEdgeInsets.zero
		tableView.preservesSuperviewLayoutMargins = false
		tableView.layoutMargins = UIEdgeInsets.zero
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 100
	}
	
	static func setupTabBar(navController: UINavigationController, tabItem: UITabBarItem, tabName: String) {
		tabItem.setTitleTextAttributes(Storage.tabTitleTextAttributes, for: UIControlState())
		tabItem.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -12.0)
		navController.tabBarItem = tabItem
		navController.navigationBar.barTintColor = UIColor.black
		navController.navigationBar.isTranslucent = false
		navController.navigationBar.topItem?.title = tabName
	}
	
	static func setupCollectionView(colView: UICollectionView, view: UIView) {
		let width = view.bounds.width
		let flowLayout = CollectionViewFlowLayout()
		flowLayout.headerReferenceSize = CGSize(width: width, height: 20)
		flowLayout.footerReferenceSize = CGSize(width: width, height: 20)
		colView.collectionViewLayout = flowLayout
		colView.allowsSelection = true
		colView.allowsMultipleSelection = false
	}
	
	static func constrainInView(vc: UIViewController, content: UIViewController, parentView: UIView) {
		vc.addChildViewController(content)
		parentView.addSubview(content.view)
		content.didMove(toParentViewController: vc)
		let horzConstraints: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "H:|[content]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["content": content.view])
		let vertConstraints: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:|[content]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["content": content.view])
		vc.view!.addConstraints(horzConstraints)
		vc.view!.addConstraints(vertConstraints)
		content.view.translatesAutoresizingMaskIntoConstraints = false
	}
	
}
