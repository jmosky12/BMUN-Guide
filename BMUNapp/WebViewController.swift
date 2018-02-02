//
//  WebViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 10/11/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

//Supports loading Delegate Guide PDF's and the potential to load webpages in the app

class WebViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    var fileName: String!
    
    init(file: String) {
        super.init(nibName: nil, bundle: nil)
        self.fileName = file
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = UIRectEdge()
        
        let path: String = Bundle.main.path(forResource: fileName, ofType: "pdf")!
        let targetURL: URL = URL(fileURLWithPath: path)
        let request: URLRequest = URLRequest(url: targetURL)
        self.webView.loadRequest(request)
        self.webView.scalesPageToFit = true
        view.addSubview(webView)
        
        let textColor = UIColor.white
        let textFont = UIFont(name: "Avenir", size: 40.0)
        
        // Sets characteristics for top bar text
        if fileName == "map" {
            let titleTextAttributes: [NSAttributedStringKey:Any] = [
				NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): textFont!,
				NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): textColor,
            ]
            self.navigationController!.navigationBar.titleTextAttributes = titleTextAttributes
        } else {
            self.navigationController!.navigationBar.tintColor = UIColor.white
        }
    }

}
